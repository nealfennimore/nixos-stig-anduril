''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268133

  machine.succeed("[[ $(grep '^PASS_MAX_DAYS' /etc/login.defs | awk '{print $2}') -ge 180 ]]")
''
