''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268105
  machine.succeed("grep -q 'disk_full_action = HALT' /etc/audit/auditd.conf")

''