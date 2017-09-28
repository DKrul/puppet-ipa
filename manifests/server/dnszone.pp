define ipa::server::dnszone(
  $ensure = present,
  $ttl = 3600,
) {
  ipa_zonerecord { $name:
    ensure => $ensure,
    ttl    => $ttl
  }
}
