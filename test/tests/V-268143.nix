''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268143

  machine.succeed("grep -q 'ClientAliveCountMax 1' /etc/ssh/sshd_config ")

''
