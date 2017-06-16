Puppet::Type.type(:ipa_user).provide :ipa_user do
  desc 'Manage IPA User records'

  commands :ipa => '/bin/ipa'

  def create
    full_name = resource[:first] + ' ' + resource[:last]
    if @update
      debug "Updating User %s" % resource[:name]
      notice('Properties of User changed - updating record')
      ipa 'user-mod', resource[:name],\
        '--first', resource[:first],\
        '--last', resource[:last],\
        '--cn', full_name,\
        '--displayname', full_name,\
        '--initials', resource[:initials],\
        '--email', resource[:email],\
        '--gecos', full_name,\
        '--shell', resource[:shell],\
        '--homedir', resource[:base_homedir] + '/' + resource[:name]
    else
      debug "Creating User %s" % resource[:name]
      ipa 'user-add', resource[:name],\
        '--first', resource[:first],\
        '--last', resource[:last],\
        '--cn', full_name,\
        '--displayname', full_name,\
        '--initials', resource[:initials],\
        '--email', resource[:email],\
        '--gecos', full_name,\
        '--shell', resource[:shell],\
        '--homedir', resource[:base_homedir] + '/' + resource[:name]
    end
  end

  def destroy
    debug 'Removing User %s' % resource[:name]
    ipa "user-del", resource[:name]
  end

  def exists?
    begin
      result = ipa "user-show", resource[:name], "--all", "--raw"
    rescue Exception => e
      return false
    end
    result = Hash[*result.gsub!(/[\n]+/, ':').chomp(':').split(':').map(&:lstrip)]
    full_name = result['givenname'] + ' ' + result['sn']
    if result['givenname'] == resource[:first] and\
      result['sn'] == resource[:last] and\
      result['cn'] == full_name and\
      result['displayName'] == full_name and\
      result['mail'] == resource[:email] and\
      result['gecos'] == full_name and\
      result['loginshell'] == resource[:shell] and\
      result['homedirectory'] == resource[:base_homedir] + '/' + resource[:name]
      return true
    else
      @update = true
      @result = result
    end
    return false
  end

end
