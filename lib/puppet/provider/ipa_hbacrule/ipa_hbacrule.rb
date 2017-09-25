Puppet::Type.type(:ipa_hbacrule).provide :ipa_hbacrule do
  desc "Manage IPA HBACrule records"

  commands :ipa => "/bin/ipa"

  def create
    if @update
      debug 'Updating HBACrule %s' % resource[:name]
      notice("Properties of HBACrule changed - updating record")
      ipa "hbacrule-mod", resource[:name], "--usercat", resource[:user_category], "--hostcat", resource[:host_category], "--servicecat", resource[:service_category], "--desc", resource[:description]
    else
      debug 'Creating HBACrule %s' % resource[:name]
      ipa "hbacrule-add", resource[:name], "--usercat", resource[:user_category], "--hostcat", resource[:host_category], "--servicecat", resource[:service_category], "--desc", resource[:description]
    end
  end

  def destroy
    debug 'Removing HBAC rule %s' % resource[:name]
    ipa "hbacrule-del", resource[:name]
  end

  def exists?
    begin
      result = ipa "hbacrule-show", resource[:name], "--all"
    rescue Exception => e
      return false
    end
    result = Hash[*result.gsub!(/[\n]+/, ':').chomp(':').split(':').map(&:lstrip)]
    if result['Description'] == resource[:description] and result['Service category'] == resource[:service_category]
        return true
    else
      @update = true
      @result = result
    end
    return false
  end

end
