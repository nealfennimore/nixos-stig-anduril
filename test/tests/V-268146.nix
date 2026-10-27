''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268146

  machine.fail("which wpa_supplicant")

  machine.fail("systemctl is-enabled wpa_supplicant.service")
''
