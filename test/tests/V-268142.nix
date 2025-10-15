''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268142
  machine.succeed("[[ $(grep 'ClientAliveInterval' /etc/ssh/sshd_config | awk '{print $2}') -ge 600 ]]")

''