Puppet::Type.type(:ipa_hostgroupmember).provide :ipa_groupmember do
  desc "Manage IPA Host Group member records"

  commands :ipa => "/bin/ipa"

  def create
    debug 'Adding member %s to hostgroup %s' % [resource[:name], resource[:groupname]]
    case resource[:type]
      when :host
        param = '--hosts'
      when :group
        param = '--hostgroups'
    end
    ipa "hostgroup-add-member", resource[:groupname], param, resource[:name]
  end

  def destroy
    debug 'Removing member %s from hostgroup %s' % [resource[:name], resource[:groupname]]
    case resource[:type]
      when :host
        param = '--hosts'
      when :group
        param = '--hostgroups'
    end
    ipa "hostgroup-remove-member", resource[:groupname], param, resource[:name]
  end

  def exists?
    begin
      result = ipa "hostgroup-show", resource[:groupname]
    rescue Exception => e
      return false
    end
    result = Hash[*result.gsub!(/[\n]+/, ':').chomp(':').split(':').map(&:lstrip)]
    case resource[:type]
      when :host
        param = 'Member hosts'
      when :group
        param = 'Member host-groups'
    end
    if result[param]
      if result[param].include? resource[:name]
        return true
      else
        @update = true
        @result = result
      end
    end
    return false
  end

end
