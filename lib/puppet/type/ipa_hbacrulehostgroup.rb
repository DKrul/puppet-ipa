Puppet::Type.newtype(:ipa_hbacrulehostgroup) do
  desc "Manage IPA HBACrule hostgroups"

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

  newparam(:hostgroup) do
    desc "The hostgroup to add to the HBACrule"
  end

  newparam(:hbacrule) do
    desc "The HBACrule to add the hostgroup to"
    defaultto ''
  end

end
