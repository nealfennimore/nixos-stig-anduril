''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268172

  machine.fail("grep -qi 'AutomaticLogin' /etc/gdm/custom.conf")

  machine.fail("grep -qi 'TimedLogin' /etc/gdm/custom.conf")
''
