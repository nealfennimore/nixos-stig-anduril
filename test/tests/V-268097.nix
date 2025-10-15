''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268097

  machine.succeed("auditctl -l | grep -qe '-w /var/cron/tabs -p wa -k services'")

  machine.succeed("auditctl -l | grep -qe '-w /var/cron/cron.allow -p wa -k services'")

  machine.succeed("auditctl -l | grep -qe '-w /var/cron/cron.deny -p wa -k services'")

''
