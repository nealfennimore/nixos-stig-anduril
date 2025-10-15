''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268128
  machine.succeed("grep -qE 'dcredit=-[0-9]{1}' /etc/security/pwquality.conf")

''