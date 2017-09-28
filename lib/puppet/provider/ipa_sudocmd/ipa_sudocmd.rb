Puppet::Type.type(:ipa_sudocmd).provide :ipa_sudocmd do
  desc "Manage IPA SUDOcmd records"

  commands :ipa => "/bin/ipa"

  def create
    if @update
      debug 'Updating SUDOcmd %s' % resource[:name]
      notice("Properties of SUDOcmd changed - updating record")
      ipa "sudocmd-mod", resource[:name], "--desc", resource[:description]
    else
      debug 'Creating SUDOcmd %s' % resource[:name]
      ipa "sudocmd-add", resource[:name], "--desc", resource[:description]
    end
  end

  def destroy
    debug 'Removing Host Group %s' % resource[:name]
    ipa "sudocmd-del", resource[:name]
  end

  def exists?
    begin
      result = ipa "sudocmd-show", resource[:name], "--all", "--raw"
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
