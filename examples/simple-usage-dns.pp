# here is some basic usage of the ipa module

# on the ipa server:
$domain = 'example.com'

class { 'ipa::server':
	domain         => ${domain},
  dm_password    => 'password',
  admin_password => 'password',
  dns            => true,
}

ipa_dnsrecord { 'test':
  ensure         => present,
  zone           => 'example.com',
  ipaddress      => '10.10.10.117',
  require        => Ipa_zonerecord['10.in-addr.arpa']
}
ipa_zonerecord { '10.in-addr.arpa':
  ensure => present,
  ttl    => '1800',
}
ipa_forwardzonerecord { 'example2.com':
  ensure    => present,
  forwarder => '10.10.10.116'
}

