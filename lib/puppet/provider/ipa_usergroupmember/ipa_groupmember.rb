Puppet::Type.type(:ipa_usergroupmember).provide :ipa_groupmember do
  desc "Manage IPA User Group member records"

  commands :ipa => "/bin/ipa"

  def create
    debug 'Adding member %s to group %s' % [resource[:member], resource[:groupname]]
    case resource[:type]
      when :user
        param = '--users'
      when :group
        param = '--groups'
      when :external
        param = '--external'
    end
    ipa "group-add-member", resource[:groupname], param, resource[:member]
  end

  def destroy
    debug 'Removing member %s from group %s' % [resource[:member], resource[:groupname]]
    case resource[:type]
      when :user
        param = '--users'
      when :group
        param = '--groups'
      when :external
        param = '--external'
    end
    ipa "group-remove-member", resource[:groupname], param, resource[:member]
  end

  def exists?
    begin
      result = ipa "group-show", resource[:groupname]
    rescue Exception => e
      return false
    end
    result = Hash[*result.gsub!(/[\n]+/, ':').chomp(':').split(':').map(&:lstrip)]
    case resource[:type]
      when :user
        param = 'Member users'
      when :group
        param = 'Member groups'
      when :external
        param = 'External member'
    end
    if result[param]
      if result[param].include? resource[:member]
        return true
      else
        @update = true
        @result = result
      end
    end
    return false
  end

end
