''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268139
  machine.succeed("[[ $(systemctl is-active usbguard.service) == 'active' ]] && [[ $(systemctl is-enabled usbguard.service) == 'enabled' ]]")

''