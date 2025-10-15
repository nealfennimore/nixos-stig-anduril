''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268104

  machine.succeed("grep -q 'admin_space_left = 10%' /etc/audit/auditd.conf")

''
