''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268136

  machine.succeed("grep -q opencryptoki /tmp/current-system")

''
