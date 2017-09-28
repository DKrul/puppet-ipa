Puppet::Type.newtype(:ipa_sudorulerunasuser) do
  desc "Manage IPA SUDOrule runasusers"

  ensurable do
    newvalue(:present) do
      provider.create
    end
    newvalue(:absent) do
      provider.destroy
    end
    defaultto :present
  end

  newparam(:name) do
    desc "Name of resource"
    isnamevar
  end

  newparam(:runasuser) do
    desc "The runasuser to add to the SUDOrule"
  end

  newparam(:sudorule) do
    desc "The SUDOrule to add the runasuser to"
    defaultto ''
  end

end
