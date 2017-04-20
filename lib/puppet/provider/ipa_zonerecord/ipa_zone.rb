Puppet::Type.type(:ipa_zonerecord).provide :ipa_zone do
  desc "Manage IPA DNS zone records"

  commands :ipa => "/bin/ipa"

  def create
    debug 'Creating DNS zone record %s' % resource[:name]
    ipa "dnszone-add", resource[:zonename], "--default-ttl", "3600", "--ttl", resource[:ttl].to_i, "--dynamic-update", resource[:dynamic_update].to_s.eql?('true') ? true : false, "--allow-query", resource[:allow_query].join(';')+';', "--allow-transfer", resource[:allow_transfer].join(';')+';'
  end

  def destroy
    debug 'Removing DNS zone record %s' % resource[:name]
    ipa "dnszone-del", resource[:zonename]
  end

  def exists?
    begin
      result = ipa "dnszone-show", resource[:zonename], "--all", "--raw"
    rescue Exception => e
      return false
    end
    result = Hash[*result.gsub!(/[\n]+/, ':').delete(' ').chomp(':').split(':')]
    if result['idnsname'].chomp('.') == resource[:zonename].chomp('.')
      return true
    end
    return false
  end
end
