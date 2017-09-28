define ipa::server::hbacrule(
  $ensure = present,
  $service_category = 'all',
  $hostgroups = [],
  $usergroups = [],
  $description = $name,
) {
  ipa_hbacrule { $name:
    ensure           => $ensure,
    service_category => $service_category,
    description      => $description,
  }
  $hostgroups.each | String $hostgroup, Hash $value | {
    ipa_hbacrulehostgroup { "${name}_${hostgroup}":
      ensure    => $value['ensure'],
      hbacrule  => $name,
      hostgroup => $hostgroup,
    }
  }
  $usergroups.each | String $usergroup, Hash $value | {
    ipa_hbacruleusergroup { "${name}_${usergroup}":
      ensure    => $value['ensure'],
      hbacrule  => $name,
      usergroup => $usergroup,
    }
  }
}
