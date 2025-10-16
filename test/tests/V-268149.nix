''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268149

  machine.succeed("timedatectl show-timesync | grep -q 'usnogps.navy.mil'")
''
