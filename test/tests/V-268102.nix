''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268102

  machine.succeed("grep -q 'admin_space_left_action = syslog' /etc/audit/auditd.conf")

''
