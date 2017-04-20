Puppet::Type.type(:ipa_forwardzonerecord).provide :ipa_forwardzone do
  desc "Manage IPA DNS forwardzone records"

  commands :ipa => "/bin/ipa"

  def create
    debug 'Creating DNS forwardzone record %s' % resource[:name]
    ipa "dnsforwardzone-add", resource[:zonename], "--forwarder", resource[:forwarder], "--forward-policy", resource[:forward_policy]
  end

  def destroy
    debug 'Removing DNS forwardzone record %s' % resource[:name]
    ipa "dnsforwardzone-del", resource[:zonename]
  end

  def exists?
    begin
      result = ipa "dnsforwardzone-show", resource[:zonename], "--all", "--raw"
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
