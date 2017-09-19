Puppet::Type.type(:ipa_sudorulecmdgroup).provide :ipa_sudorulecmdgroup do
  desc "Manage IPA SUDOrule cmdgroups"

  commands :ipa => "/bin/ipa"

  def create
    debug 'Adding cmdgroup %s to SUDOrule %s' % [resource[:cmdgroup], resource[:sudorule]]
    ipa "sudorule-add-allow-command", resource[:sudorule], "--sudocmdgroups", resource[:cmdgroup]
  end

  def destroy
    debug 'Removing cmdgroup %s from SUDOrule %s' % [resource[:cmdgroup], resource[:sudorule]]
    ipa "sudorule-remove-allow-command", resource[:sudorule], "--sudocmdgroups", resource[:cmdgroup]
  end

  def exists?
    begin
      result = ipa "sudorule-show", resource[:sudorule]
    rescue Exception => e
      return false
    end
    result = Hash[*result.gsub!(/[\n]+/, ':').chomp(':').split(':').map(&:lstrip)]
    if result['Sudo Allow Command Groups']
      if result['Sudo Allow Command Groups'].include? resource[:cmdgroup]
        return true
      end
    end
    return false
  end

end
