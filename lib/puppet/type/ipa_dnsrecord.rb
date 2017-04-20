Puppet::Type.newtype(:ipa_dnsrecord) do
  desc "Manage IPA DNS records"

  ensurable

  newparam(:record) do
    desc "The record name to be created"

    isnamevar
  end

  newparam(:zone) do
    desc "The zone in which the record will be created"
  end

  newparam(:ipaddress) do
    desc "The ipaddress which should be associated with the record"
  end

  newparam(:create_reverse) do
    desc "Create reverse record yes or no"
    defaultto true
  end

end
