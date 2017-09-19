Puppet::Type.newtype(:ipa_sudorulecmdgroup) do
  desc "Manage IPA SUDOrule cmdgroups"

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

  newparam(:cmdgroup) do
    desc "The cmdgroup to add to the SUDOrule"
  end

  newparam(:sudorule) do
    desc "The SUDOrule to add the cmdgroup to"
    defaultto ''
  end

end
