''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268152

  machine.succeed("grep -qE '^allowed-users = root @wheel$' /etc/nix/nix.conf")
''
