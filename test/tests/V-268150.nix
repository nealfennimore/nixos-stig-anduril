''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268150
  machine.succeed("timedatectl show-timesync | grep -q 'PollIntervalMaxUSec=1min'")

''