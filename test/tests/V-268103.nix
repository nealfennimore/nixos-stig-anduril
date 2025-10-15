''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268103

  machine.succeed("grep -q 'space_left = 25%' /etc/audit/auditd.conf")

''
