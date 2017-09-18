Puppet::Type.newtype(:ipa_sudorulehostgroup) do
  desc "Manage IPA SUDOrule hostgroups"

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
    desc "The hostgroup to add to the SUDOrule"
  end

  newparam(:sudorule) do
    desc "The SUDOrule to add the hostgroup to"
    defaultto ''
  end

end
