''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268151
  machine.succeed("timedatectl status | grep -q 'NTP service: active'")

''