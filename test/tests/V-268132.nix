''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268132

  machine.succeed("grep -qE '^PASS_MIN_DAYS[[:space:]]+1$' /etc/login.defs")
''
