''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268107

  machine.succeed("[[ $(systemctl is-active syslog-ng.service) == 'active' ]] && [[ $(systemctl is-enabled syslog-ng.service) == 'enabled' ]]")

''
