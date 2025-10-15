''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268119
  machine.succeed("auditctl -s | grep -qe 'loginuid_immutable 1 locked'")

''