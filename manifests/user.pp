define ipa::user(
  $ensure = present,
  $domain = '',
  $first = '',
  $last = '',
  $email = '',
  $memberofgroup
) {
  ipa_user { $name:
    ensure => $ensure,
    domain => $domain,
    first  => $first,
    last   => $last,
    email  => $email
  }
  $memberofgroup.each | String $group, Hash $value | {
    ipa_usergroupmember { "${name}_${group}":
      member    => $name,
      ensure    => $value['ensure'],
      groupname => $group,
      type      => 'user'
    }
  }   
}
