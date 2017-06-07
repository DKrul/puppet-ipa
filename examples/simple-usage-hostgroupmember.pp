#Add host ipa.cmc.lan to hostgroup testhostgroup
ipa_hostgroupmember { 'ipa.cmc.lan':
  ensure    =>  present,
  groupname => 'testhostgroup',
  type      => 'host'
}

#Add hostgroup ipaservers to hostgroup testhostgroup
ipa_hostgroupmember { 'ipaservers':
  ensure    =>  present,
  groupname => 'testhostgroup',
  type      => 'group'
}
