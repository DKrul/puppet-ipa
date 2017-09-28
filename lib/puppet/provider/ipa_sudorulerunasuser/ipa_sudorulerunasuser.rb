Puppet::Type.type(:ipa_sudorulerunasuser).provide :ipa_sudorulerunasuser do
  desc "Manage IPA SUDOrule runasusers"

  commands :ipa => "/bin/ipa"

  def create
    debug 'Adding runasuser %s to SUDOrule %s' % [resource[:runasuser], resource[:sudorule]]
    ipa "sudorule-add-runasuser", resource[:sudorule], "--users", resource[:runasuser]
  end

  def destroy
    debug 'Removing runasuser %s from SUDOrule %s' % [resource[:runasuser], resource[:sudorule]]
    ipa "sudorule-remove-runasuser", resource[:sudorule], "--users", resource[:runasuser]
  end

  def exists?
    begin
      result = ipa "sudorule-show", resource[:sudorule]
    rescue Exception => e
      return false
    end
    result = Hash[*result.gsub!(/[\n]+/, ':').chomp(':').split(':').map(&:lstrip)]
    if result['RunAs Users']
      if result['RunAs Users'].include? resource[:runasuser]
        return true
      end
    elsif result['RunAs External User']
      if result['RunAs External User'].include? resource[:runasuser]
        return true
      end
    end
    return false
  end

end
