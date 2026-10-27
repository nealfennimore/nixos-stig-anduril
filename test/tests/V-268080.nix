''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268080

  machine.wait_for_unit("auditd.service")

  machine.succeed("[[ $(systemctl is-active auditd.service) == 'active' ]]")

  # NOTE: nixpkgs loads the rules from audit-rules-nixos.service, there is no audit.service

  machine.succeed("[[ $(systemctl is-active audit-rules-nixos.service) == 'active' ]]")
''
