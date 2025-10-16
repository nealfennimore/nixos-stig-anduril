''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268082

  machine.wait_for_unit("auditd.service")

  machine.succeed("[[ $(systemctl is-active auditd.service) == 'active' ]]")

  machine.succeed("which auditctl")
''
