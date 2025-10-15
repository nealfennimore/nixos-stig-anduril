''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268159

  machine.succeed("[[ $(systemctl is-active sshd.service) == 'active' ]] && [[ $(systemctl is-enabled sshd.service) == 'enabled' ]]")

''
