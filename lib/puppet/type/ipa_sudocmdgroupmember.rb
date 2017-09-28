Puppet::Type.newtype(:ipa_sudocmdgroupmember) do
  desc "Manage IPA CMD Group member records"

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

  newparam(:command) do
    desc "Member to add to a group"
  end

  newparam(:groupname) do
    desc "The group name to which the members will be added"
  end

end
