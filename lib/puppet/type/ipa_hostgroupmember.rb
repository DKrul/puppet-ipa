Puppet::Type.newtype(:ipa_hostgroupmember) do
  desc "Manage IPA Host Group member records"

  ensurable

  newparam(:member) do
    desc "Member to add to a hostgroup"

    isnamevar
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
