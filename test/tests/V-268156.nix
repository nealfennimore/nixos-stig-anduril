''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268156
  machine.succeed("grep -q '%wheel  ALL=(ALL:ALL)    SETENV: ALL' /etc/sudoers")

''