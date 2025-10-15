''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268126

  machine.succeed("grep -qE 'ucredit=-[0-9]{1}' /etc/security/pwquality.conf")

''
