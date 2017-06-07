Puppet::Type.type(:ipa_hostgroup).provide :ipa_group do
  desc "Manage IPA Host Group records"

  commands :ipa => "/bin/ipa"

  def create
    if @update
      debug 'Updating Host Group record %s' % resource[:name]
      notice("Properties of Host Group record changed - updating record")
      ipa "hostgroup-mod", resource[:name], "--desc", resource[:description]
    else
      debug 'Creating Host Group record %s' % resource[:name]
      ipa "hostgroup-add", resource[:name], "--desc", resource[:description]
    end
  end

  def destroy
    debug 'Removing Host Group %s' % resource[:name]
    ipa "hostgroup-del", resource[:name]
  end

  def exists?
    begin
      result = ipa "hostgroup-show", resource[:name], "--all", "--raw"
    rescue Exception => e
      return false
    end
    result = Hash[*result.gsub!(/[\n]+/, ':').chomp(':').split(':').map(&:lstrip)]
    if result['description'] == resource[:description]
      return true
    else
      @update = true
      @result = result
    end
    return false
  end

end
