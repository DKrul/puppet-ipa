Puppet::Type.newtype(:ipa_hbacrule) do
  desc "Manage IPA HBACrule records"

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
    desc "The HBACrule name to be created"

    isnamevar
  end

  newparam(:user_category) do
    desc "The initial user category the rule applies to"
    defaultto ''
  end

  newparam(:host_category) do
    desc "The initial host category the rule applies to"
    defaultto ''    
  end

  newparam(:service_category) do
    desc "The initial services the rule applies to"
    defaultto 'all'
  end
  
  newparam(:description) do
    desc "A description for the HBACrule"
    defaultto ''
  end

end
