Puppet::Type.type(:ipa_hbacrulehostgroup).provide :ipa_hbacrulehostgroup do
  desc "Manage IPA HBACrule hostgroups"

  commands :ipa => "/bin/ipa"

  def create
    debug 'Adding hostgroup %s to HBACrule %s' % [resource[:hostgroup], resource[:hbacrule]]
    ipa "hbacrule-add-host", resource[:hbacrule], "--hostgroups", resource[:hostgroup]
  end

  def destroy
    debug 'Removing hostgroup %s from HBACrule %s' % [resource[:hostgroup], resource[:hbacrule]]
    ipa "hbacrule-remove-host", resource[:hbacrule], "--hostgroups", resource[:hostgroup]
  end

  def exists?
    begin
      result = ipa "hbacrule-show", resource[:hbacrule]
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
