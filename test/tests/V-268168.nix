''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268168

  machine.succeed("grep -q 'fips=1' /proc/cmdline")

''
