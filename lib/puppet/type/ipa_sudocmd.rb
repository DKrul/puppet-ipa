Puppet::Type.newtype(:ipa_sudocmd) do
  desc "Manage IPA SUDOcmd records"

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
    desc "The SUDOcmd name to be created"

    isnamevar
  end

  newparam(:description) do
    desc "A description for the SUDOcmd"
    defaultto ''
  end

end
