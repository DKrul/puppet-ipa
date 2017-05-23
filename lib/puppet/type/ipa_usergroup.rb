Puppet::Type.newtype(:ipa_usergroup) do
  desc "Manage IPA User Group records"

  ensurable

  newparam(:name) do
    desc "The group name to be created"

    isnamevar
  end

  newparam(:description) do
    desc "A description for the group name"
    defaultto ''
  end

  newparam(:gid) do
    desc "A manually selected group id. This is normally auto generated (and advised to be auto generated)"
    defaultto 0
  end

  newparam(:posix) do
    desc "Create a POSIX group or not"
    defaultto true
  end

  newparam(:external) do
    desc "User group is an external group"
    defaultto false
  end

end
