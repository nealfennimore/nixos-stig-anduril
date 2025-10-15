''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268171
  machine.succeed("[[ $(grep 'FAIL_DELAY' /etc/login.defs | awk '{print $2}') -ge 4 ]]")

''