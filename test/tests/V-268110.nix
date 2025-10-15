''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268110

  machine.succeed("grep -q 'log_group = root' /etc/audit/auditd.conf")

''
