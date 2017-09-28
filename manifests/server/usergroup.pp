define ipa::server::usergroup(
  $ensure = present,
  $description = '',
) {
  ipa_usergroup { $name:
    ensure      => $ensure,
    description => $description
  }
}
