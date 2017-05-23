ipa_usergroupmember { 'fabian.vanderhoeven':
  ensure    =>  absent,
  groupname => 'test',
  type      => 'user'
}
