Puppet::Type.newtype(:ipa_sudoruleusergroup) do
  desc "Manage IPA SUDOrule usergroups"

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
    desc "The usergroup to add to the SUDOrule"
  end

  newparam(:sudorule) do
    desc "The SUDOrule to add the usergroup to"
    defaultto ''
  end

end
