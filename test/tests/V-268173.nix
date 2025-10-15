''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268173

  machine.succeed("[[ $(systemctl is-active apparmor.service) == 'active' ]] && [[ $(systemctl is-enabled apparmor.service) == 'enabled' ]]")

''
