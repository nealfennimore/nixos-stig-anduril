''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268154

  machine.succeed("grep -qE '^require-sigs = true$' /etc/nix/nix.conf")
''
