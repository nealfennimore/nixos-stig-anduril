''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268133
  machine.succeed("grep -q 'PASS_MAX_DAYS 60' /etc/login.defs")

''