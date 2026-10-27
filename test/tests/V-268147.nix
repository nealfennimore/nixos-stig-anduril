''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268147

  machine.fail("systemctl is-enabled bluetooth.service")
''
