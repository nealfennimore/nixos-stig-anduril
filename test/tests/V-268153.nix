''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268153
  machine.succeed("grep -q aide /tmp/current-system")
  machine.succeed("[[ -f /etc/aide/aide.conf ]]")

''