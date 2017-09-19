# *puppet-ipa*: a puppet module for FreeIPA

---
**This repo is a fork of purpleidea, but a lot has changed is this repo. So some of the functionality may not work with this module**
Stuff that hass been added to this module:
- Management of users has been moved to custom types/provider
- Management of DNS zones
- Management of DNS records
- Management of DNS forward zones
- Management of Hostgroups
- Management of Usergroups
- Management of sudo command groups
- Management of sudorules
  - usergroups
  - hostgroups
  - command groups
  - runasusers
  - options

Documentation about these additions also needs to be added.

---


## Documentation:
Please see: [DOCUMENTATION.md](DOCUMENTATION.md) or [PDF](https://pdfdoc-purpleidea.rhcloud.com/pdf/https://github.com/purpleidea/puppet-ipa/blob/master/DOCUMENTATION.md).

## Installation:
Please read the [INSTALL](INSTALL) file for instructions on getting this installed.

## Examples:
Please look in the [examples/](examples/) folder for usage. If none exist, please contribute one!

## Module specific notes:
* This is a rather elaborate module. Be sure to review the code before using.
* There are a number of (useful) lengthy comments and explanations in the code.
* This module plays nicely with my puppet-nfs module. Use them together :)

## Dependencies:
* [puppetlabs-stdlib](https://github.com/puppetlabs/puppetlabs-stdlib) (required)
* my [puppet-shorewall](https://github.com/purpleidea/puppet-shorewall) module (optional)
* my [puppet-puppet](https://github.com/purpleidea/puppet-puppet) module (optional)
* my [puppet-nfs](https://github.com/purpleidea/puppet-nfs) module (optional)

## Patches:
This code may be a work in progress. The interfaces may change without notice.
Patches are welcome, but please be patient. They are best received by email.
Please ping me if you have big changes in mind, before you write a giant patch.

##

Happy hacking!

