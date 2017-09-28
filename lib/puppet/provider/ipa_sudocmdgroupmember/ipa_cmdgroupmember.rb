Puppet::Type.type(:ipa_sudocmdgroupmember).provide :ipa_groupmember do
  desc "Manage IPA CMD Group member records"

  commands :ipa => "/bin/ipa"

  def create
    debug 'Adding member %s to cmdgroup %s' % [resource[:command], resource[:groupname]]
    ipa "sudocmdgroup-add-member", resource[:groupname], '--sudocmds', resource[:command]
  end

  def destroy
    debug 'Removing member %s from cmdgroup %s' % [resource[:command], resource[:groupname]]
    ipa "sudocmdgroup-remove-member", resource[:groupname], '--sudocmds', resource[:command]
  end

  def exists?
    begin
      result = ipa "sudocmdgroup-show", resource[:groupname]
    rescue Exception => e
      return false
    end
    result = Hash[*result.gsub!(/[\n]+/, ':').chomp(':').split(':').map(&:lstrip)]
    if result['Member Sudo commands']
      if result['Member Sudo commands'].include? resource[:command]
        return true
      else
        @update = true
        @result = result
      end
    end
    return false
  end

end
