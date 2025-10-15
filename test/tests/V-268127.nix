''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268127
  machine.succeed("grep -qE 'lcredit=-[0-9]{1}' /etc/security/pwquality.conf")

''