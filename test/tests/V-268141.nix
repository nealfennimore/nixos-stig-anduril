''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268141
  machine.succeed("sysctl net.ipv4.tcp_syncookies | grep -q 'net.ipv4.tcp_syncookies = 1'")

''