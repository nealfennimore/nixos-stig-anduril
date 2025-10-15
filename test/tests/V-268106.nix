''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268106
  machine.succeed("grep -q 'disk_error_action = HALT' /etc/audit/auditd.conf")

''