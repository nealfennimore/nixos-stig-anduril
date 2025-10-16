''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268083

  machine.succeed("grep -q USG $(grep Banner /etc/ssh/sshd_config | awk '{print $2}')")
''
