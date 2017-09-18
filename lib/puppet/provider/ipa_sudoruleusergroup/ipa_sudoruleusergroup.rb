Puppet::Type.type(:ipa_sudoruleusergroup).provide :ipa_sudoruleusergroup do
  desc "Manage IPA SUDOrule usergroups"

  commands :ipa => "/bin/ipa"

  def create
    debug 'Adding usergroup %s to SUDOrule %s' % [resource[:usergroup], resource[:sudorule]]
    ipa "sudorule-add-user", resource[:sudorule], "--groups", resource[:usergroup]
  end

  def destroy
    debug 'Removing usergroup %s from SUDOrule %s' % [resource[:usergroup], resource[:sudorule]]
    ipa "sudorule-remove-user", resource[:sudorule], "--groups", resource[:usergroup]
  end

  def exists?
    begin
      result = ipa "sudorule-show", resource[:sudorule]
    rescue Exception => e
      return false
    end
    result = Hash[*result.gsub!(/[\n]+/, ':').chomp(':').split(':').map(&:lstrip)]
    if result['User Groups']
      if result['User Groups'].include? resource[:usergroup]
        return true
      end
    end
    return false
  end

end
