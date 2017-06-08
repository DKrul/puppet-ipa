Puppet::Type.newtype(:ipa_sudorule) do
  desc "Manage IPA SUDOrule records"

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
    desc "The SUDOrule name to be created"

    isnamevar
  end

  newparam(:description) do
    desc "A description for the SUDOrule"
    defaultto ''
  end

end
