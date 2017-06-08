Puppet::Type.newtype(:ipa_forwardzonerecord) do
  desc "Manage IPA DNS forwardzone records"

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
    desc "The forwardzone name to be created"

    isnamevar
  end

  newparam(:forwarder) do
    desc "IP address of the forwarder"
  end

  newparam(:forward_policy) do
    desc "The forward policy (none, first (default) or only)"
    defaultto 'first'
  end

end
