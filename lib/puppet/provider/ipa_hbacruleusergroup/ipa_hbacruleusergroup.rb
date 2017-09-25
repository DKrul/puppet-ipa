Puppet::Type.type(:ipa_hbacruleusergroup).provide :ipa_hbacruleusergroup do
  desc "Manage IPA HBACrule usergroups"

  commands :ipa => "/bin/ipa"

  def create
    debug 'Adding usergroup %s to HBACrule %s' % [resource[:usergroup], resource[:hbacrule]]
    ipa "hbacrule-add-user", resource[:hbacrule], "--groups", resource[:usergroup]
  end

  def destroy
    debug 'Removing usergroup %s from HBACrule %s' % [resource[:usergroup], resource[:hbacrule]]
    ipa "hbacrule-remove-user", resource[:hbacrule], "--groups", resource[:usergroup]
  end

  def exists?
    begin
      result = ipa "hbacrule-show", resource[:hbacrule]
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
