define ipa::dnsrecord(
  $ensure = present,
  $ipaddress = 3600,
  $create_reverse = true,
) {
  $components = split($name, "\.")

  ipa_dnsrecord { $name:
    ensure         => $ensure,
    record         => $components[0],
    zone           => join(delete_at($components,0),'.'),
    ipaddress      => $ipaddress,
    create_reverse => $create_reverse,
  }
}
