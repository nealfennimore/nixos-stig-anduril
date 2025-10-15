''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268172

  # NOTE: No desktop
  machine.fail("grep -q 'AutomaticLoginEnable=False' /etc/gdm/custom.conf")

''
