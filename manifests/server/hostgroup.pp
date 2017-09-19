define ipa::server::hostgroup(
  $ensure = present,
  $description = $name,
  $members = [],
) {
  ipa_hostgroup { $name:
    ensure      => $ensure,
    description => $description,
  }
  $members.each | String $member, Hash $value | {
    ipa_hostgroupmember { "${name}_${member}":
      ensure    => $value['ensure'],
      member    => $member,
      groupname => $name,
      type      => $value['type'],
    }
  }   
}
