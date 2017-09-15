Puppet::Type.newtype(:ipa_usergroupmember) do
  desc "Manage IPA User Group member records"

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
    desc "Member to add to a group"
  end

  newparam(:groupname) do
    desc "The group name to which the members will be added"
  end

  newparam(:type) do
    desc "Is member a user, a group or an external entity? Defaults to user"
    newvalues(:user, :group, :external)
    defaultto 'user'
  end

end
