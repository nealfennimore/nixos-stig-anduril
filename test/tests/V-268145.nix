''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268145
  machine.succeed("grep -qE 'ocredit=-[0-9]{1}' /etc/security/pwquality.conf")

''