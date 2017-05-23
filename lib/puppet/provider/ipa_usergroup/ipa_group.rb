Puppet::Type.type(:ipa_usergroup).provide :ipa_group do
  desc "Manage IPA User Group records"

  commands :ipa => "/bin/ipa"

  def create
    if @update
      debug 'Updating User Group record %s' % resource[:name]
      notice("Properties of User Group record changed - updating record")
      if resource[:gid] != 0
        if resource[:description] != @result['description'] && resource[:gid] != @result['gidnumber']
          ipa "group-mod", resource[:name], "--desc", resource[:description], '--gid', resource[:gid]
        end
        if resource[:description] == @result['description'] && resource[:gid] != @result['gidnumber']
          ipa "group-mod", resource[:name], '--gid', resource[:gid]
        end
        if resource[:description] != @result['description'] && resource[:gid] == @result['gidnumber']
          ipa "group-mod", resource[:name], "--desc", resource[:description]
        end
      else
        if resource[:description] != @result['description']
          ipa "group-mod", resource[:name], "--desc", resource[:description]
        end
      end
    else
      debug 'Creating User Group record %s' % resource[:name]
      params = ''
      if resource[:posix].to_s.eql?('false') ? true : false
        params += ' --nonposix'
      end
      if resource[:external].to_s.eql?('true') ? true : false
        params += ' --external'
      end
      if resource[:gid] != 0
        params += ' --gid=%d' % resource[:gid]
      end
      if params == ''
        ipa "group-add", resource[:name], "--desc", resource[:description]
      else
        ipa "group-add", resource[:name], "--desc", resource[:description], params
      end
    end
  end

  def destroy
    debug 'Removing User Group %s' % resource[:name]
    ipa "group-del", resource[:name]
  end

  def exists?
    begin
      result = ipa "group-show", resource[:name], "--all", "--raw"
    rescue Exception => e
      return false
    end
    result = Hash[*result.gsub!(/[\n]+/, ':').chomp(':').split(':').map(&:lstrip)]
    if result['description'] == resource[:description] && (result['gidnumber'] == resource[:gid] || resource[:gid] == 0)
      return true
    else
      @update = true
      @result = result
    end
    return false
  end

end
