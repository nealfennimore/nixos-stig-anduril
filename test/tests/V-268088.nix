''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268088

  machine.succeed("grep -q 'LogLevel VERBOSE' /etc/ssh/sshd_config")
''
