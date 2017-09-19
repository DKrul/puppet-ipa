Puppet::Type.type(:ipa_sudocmdgroup).provide :ipa_group do
  desc "Manage IPA CMD Group records"

  commands :ipa => "/bin/ipa"

  def create
    if @update
      debug 'Updating CMD Group record %s' % resource[:name]
      notice("Properties of CMD Group record changed - updating record")
      ipa "sudocmdgroup-mod", resource[:name], "--desc", resource[:description]
    else
      debug 'Creating CMD Group record %s' % resource[:name]
      ipa "sudocmdgroup-add", resource[:name], "--desc", resource[:description]
    end
  end

  def destroy
    debug 'Removing CMD Group %s' % resource[:name]
    ipa "sudocmdgroup-del", resource[:name]
  end

  def exists?
    begin
      result = ipa "sudocmdgroup-show", resource[:name], "--all", "--raw"
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
