Puppet::Type.newtype(:ipa_hbacruleusergroup) do
  desc "Manage IPA HBACrule usergroups"

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

  newparam(:usergroup) do
    desc "The usergroup to add to the HBACrule"
  end

  newparam(:hbacrule) do
    desc "The HBACrule to add the usergroup to"
    defaultto ''
  end

end
