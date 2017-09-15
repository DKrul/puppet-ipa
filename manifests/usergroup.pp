define ipa::usergroup(
  $ensure = present,
  $description = '',
) {
  ipa_usergroup { $name:
    ensure      => $ensure,
    description => $description
  }
}
