Puppet::Type.newtype(:ipa_user) do
  desc "Manage IPA User records"

  ensurable do
    newvalue(:present) do
      provider.create
    end
    newvalue(:absent) do
      provider.destroy
    end
    defaultto :present
  end

  newparam(:login) do
    desc "The login name of the user"

    isnamevar
  end

  newparam(:domain) do
    desc "The domain of which the user is a member"
    defaultto ''
  end

  newparam(:first) do
    desc "The first name of the user"
    defaultto ''
  end

  newparam(:last) do
    desc "The last name of the user"
    defaultto ''
  end

  newparam(:Initials) do
    desc "The initials of the user"
    defaultto ''
  end

  newparam(:email) do
    desc "The e-mail adress of the user"
    defaultto ''
  end

  newparam(:shell) do
    desc 'Shell used by the user'
    defaultto '/bin/bash'
  end

  newparam(:base_homedir) do
    desc 'Base of all home directories'
    defaultto '/home'
  end

end
