Puppet::Type.newtype(:ipa_sudoruleoption) do
  desc "Manage IPA SUDOrule options"

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

  newparam(:option) do
    desc "The option to add to the SUDOrule"
  end

  newparam(:sudorule) do
    desc "The SUDOrule to add the option to"
    defaultto ''
  end

end
