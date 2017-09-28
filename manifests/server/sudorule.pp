define ipa::server::sudorule(
  $ensure = present,
  $description = '',
  $options = [],
  $usergroups = [],
  $hostgroups = [],
  $cmdgroups = [],
  $runasusers = [],
) {
  ipa_sudorule { $name:
    ensure      => $ensure,
    description => $description,
  }
  $options.each | String $option | {
    ipa_sudoruleoption { "${name}_${option}":
      ensure   => $ensure,
      sudorule => $name,
      option   => $option,
    }
  }
  $usergroups.each | String $usergroup, Hash $value | {
    ipa_sudoruleusergroup { "${name}_${usergroup}":
      ensure    => $value['ensure'],
      sudorule  => $name,
      usergroup => $usergroup,
    }
  }
  $hostgroups.each | String $hostgroup, Hash $value | {
    ipa_sudorulehostgroup { "${name}_${hostgroup}":
      ensure    => $value['ensure'],
      sudorule  => $name,
      hostgroup => $hostgroup,
    }
  }
  $cmdgroups.each | String $cmdgroup, Hash $value | {
    ipa_sudorulecmdgroup { "${name}_${cmdgroup}":
      ensure   => $value['ensure'],
      sudorule => $name,
      cmdgroup => $cmdgroup,
    }
  }
  $runasusers.each | String $runasuser, Hash $value | {
    ipa_sudorulerunasuser { "${name}_${runasuser}":
      ensure    => $value['ensure'],
      sudorule  => $name,
      runasuser => $runasuser,
    }
  }
}
