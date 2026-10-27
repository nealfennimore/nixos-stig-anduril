''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268090

  machine.succeed("which auditctl")

  # NOTE: nixpkgs loads the rules from audit-rules-nixos.service, there is no audit.service

  machine.succeed("[[ $(systemctl is-active audit-rules-nixos.service) == 'active' ]]")
''
