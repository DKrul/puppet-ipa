Puppet::Type.type(:ipa_sudorule).provide :ipa_sudorule do
  desc "Manage IPA SUDOrule records"

  commands :ipa => "/bin/ipa"

  def create
    if @update
      debug 'Updating SUDOrule %s' % resource[:name]
      notice("Properties of SUDOrule changed - updating record")
      ipa "sudorule-mod", resource[:name], "--desc", resource[:description]
    else
      debug 'Creating SUDOrule %s' % resource[:name]
      ipa "sudorule-add", resource[:name], "--desc", resource[:description]
    end
  end

  def destroy
    debug 'Removing Host Group %s' % resource[:name]
    ipa "sudorule-del", resource[:name]
  end

  def exists?
    begin
      result = ipa "sudorule-show", resource[:name], "--all", "--raw"
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
