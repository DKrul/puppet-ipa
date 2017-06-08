Puppet::Type.newtype(:ipa_hostgroup) do
  desc "Manage IPA Host Group records"

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
    desc "The group name to be created"

    isnamevar
  end

  newparam(:description) do
    desc "A description for the group name"
    defaultto ''
  end

end
