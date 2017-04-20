Puppet::Type.type(:ipa_dnsrecord).provide :ipa_dns do
  desc "Manage IPA DNS records"

  commands :ipa => "/bin/ipa"

  def create
    if @update
      debug 'Updating DNS record %s' % resource[:name]
      notice("Properties of DNS record changed - updating record")
      ipa "dnsrecord-mod", resource[:zone], resource[:record], "--a-rec", @result['arecord'], '--a-ip-address', resource[:ipaddress]
    else
      debug 'Creating DNS record %s' % resource[:name]
      if resource[:create_reverse].to_s.eql?('true') ? true : false
        ipa "dnsrecord-add", resource[:zone], resource[:record], "--a-ip-address", resource[:ipaddress], '--a-create-reverse'
      else
        ipa "dnsrecord-add", resource[:zone], resource[:record], "--a-ip-address", resource[:ipaddress]
      end
    end
  end

  def destroy
    debug 'Removing DNS record %s' % resource[:name]
    ipa "dnsrecord-del", resource[:zone], resource[:record], "--a-rec", resource[:ipaddress]
  end

  def exists?
    begin
      result = ipa "dnsrecord-show", resource[:zone], resource[:record], "--all", "--raw"
    rescue Exception => e
      return false
    end
    result = Hash[*result.gsub!(/[\n]+/, ':').delete(' ').chomp(':').split(':')]
    if result['idnsname'] == resource[:record]
      if result['arecord'] == resource[:ipaddress]
        return true
      else
        @update = true
        @result = result
      end
    end
    return false
  end

end
