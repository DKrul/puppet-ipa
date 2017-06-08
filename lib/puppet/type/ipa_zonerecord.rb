Puppet::Type.newtype(:ipa_zonerecord) do
  desc "Manage IPA DNS zone records"

  ensurable do
    newvalue(:present) do
      provider.create
    end
    newvalue(:absent) do
      provider.destroy
    end
    defaultto :present
  end

  newparam(:zonename) do
    desc "The zone name to be created"

    isnamevar
  end

  newparam(:ttl) do
    desc "The zone's time to live"
    defaultto 3600
  end

  newparam(:dynamic_update) do
    desc "The type of record to be created (A, CNAME ...) TODO!"
    defaultto 'true'
  end

  newparam(:allow_query) do
    desc "Networks or IP-address which are allowed to query the zone"
    defaultto ['any']
  end

  newparam(:allow_transfer) do
    desc "Networks or IP-address which are allowed to query the zone"
    defaultto ['none']
  end

end
