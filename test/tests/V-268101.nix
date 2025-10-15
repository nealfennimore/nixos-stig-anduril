''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268101
  machine.succeed("grep -q 'space_left_action = syslog' /etc/audit/auditd.conf")

''