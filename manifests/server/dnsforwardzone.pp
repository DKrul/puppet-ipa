define ipa::server::dnsforwardzone(
  $ensure = present,
  $forwarder = 3600,
  $forward_policy = 'first'
) {
  ipa_forwardzonerecord { $name:
    ensure         => $ensure,
    forwarder      => $forwarder,
    forward_policy => $forward_policy
  }
}
