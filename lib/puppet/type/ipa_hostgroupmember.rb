Puppet::Type.newtype(:ipa_hostgroupmember) do
  desc "Manage IPA Host Group member records"

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

  newparam(:member) do
    desc "Member to add to a hostgroup"
  end

  newparam(:groupname) do
    desc "The group name to which the members will be added"
  end

  newparam(:type) do
    desc "Is member a host or a hostgroup? Defaults to host"
    newvalues(:host, :group)
    defaultto 'host'
  end

end
