define ipa::server::sudocmdgroup(
  $ensure = present,
  $description = $name,
  $commands = {},
) {
  ipa_sudocmdgroup { $name:
    ensure      => $ensure,
    description => $description,
  }
  $commands.each | String $command, Hash $value | {
    ipa_sudocmd { $command:
      ensure      => $value['ensure'],
      description => $command,
    }
    ipa_sudocmdgroupmember { "${name}_${command}":
      ensure    => $value['ensure'],
      groupname => $name,
      command   => $command
    }
  }
}
