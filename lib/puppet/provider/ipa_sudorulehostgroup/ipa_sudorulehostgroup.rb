Puppet::Type.type(:ipa_sudorulehostgroup).provide :ipa_sudorulehostgroup do
  desc "Manage IPA SUDOrule hostgroups"

  commands :ipa => "/bin/ipa"

  def create
    debug 'Adding hostgroup %s to SUDOrule %s' % [resource[:hostgroup], resource[:sudorule]]
    ipa "sudorule-add-host", resource[:sudorule], "--hostgroups", resource[:hostgroup]
  end

  def destroy
    debug 'Removing hostgroup %s from SUDOrule %s' % [resource[:hostgroup], resource[:sudorule]]
    ipa "sudorule-remove-host", resource[:sudorule], "--hostgroups", resource[:hostgroup]
  end

  def exists?
    begin
      result = ipa "sudorule-show", resource[:sudorule]
    rescue Exception => e
      return false
    end
    result = Hash[*result.gsub!(/[\n]+/, ':').chomp(':').split(':').map(&:lstrip)]
    if result['Host Groups']
      if result['Host Groups'].include? resource[:hostgroup]
        return true
      end
    end
    return false
  end

end
