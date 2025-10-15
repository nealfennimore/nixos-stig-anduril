''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268132

  machine.succeed("grep -q 'PASS_MIN_DAYS 1' /etc/login.defs")

''
