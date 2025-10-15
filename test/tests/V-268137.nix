''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268137

  machine.succeed("grep -q 'PermitRootLogin no' /etc/ssh/sshd_config")

''