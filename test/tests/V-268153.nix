''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268153

  machine.succeed("which aide")

  machine.succeed("[[ -f /etc/aide.conf ]]")

  machine.wait_for_unit("aide.service")

  machine.succeed("[[ $(systemctl is-active aide.service) == 'active' ]]")
''
