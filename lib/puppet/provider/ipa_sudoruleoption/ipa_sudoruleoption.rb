Puppet::Type.type(:ipa_sudoruleoption).provide :ipa_sudoruleoption do
  desc "Manage IPA SUDOrule options"

  commands :ipa => "/bin/ipa"

  def create
    debug 'Adding option %s to SUDOrule %s' % [resource[:option], resource[:sudorule]]
    ipa "sudorule-add-option", resource[:sudorule], "--sudooption", resource[:option]
  end

  def destroy
    debug 'Removing option %s from SUDOrule %s' % [resource[:option], resource[:sudorule]]
    ipa "sudorule-remove-option", resource[:sudorule], "--sudooption", resource[:option]
  end

  def exists?
    begin
      result = ipa "sudorule-show", resource[:sudorule]
    rescue Exception => e
      return false
    end
    result = Hash[*result.gsub!(/[\n]+/, ':').chomp(':').split(':').map(&:lstrip)]
    if result['Sudo Option']
      if result['Sudo Option'].include? resource[:option]
        return true
      end
    end
    return false
  end

end
