''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268166
  machine.succeed("auditctl -l | grep -qe '-w /var/log/lastlog -p wa -k logins'")

''