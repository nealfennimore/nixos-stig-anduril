''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268155
  machine.succeed("grep -q 'Defaults timestamp_timeout=0' /etc/sudoers")

''