''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268176
  machine.succeed("sshd -G | grep -q 'usepam yes'")

''