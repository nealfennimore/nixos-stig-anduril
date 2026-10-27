''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268130

  machine.succeed("grep -qE '^ENCRYPT_METHOD[[:space:]]+SHA512$' /etc/login.defs")
''
