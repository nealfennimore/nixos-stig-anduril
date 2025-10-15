''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268178

  machine.succeed("grep -q 'offline_credentials_expiration = 1' /etc/sssd/sssd.conf")

''
