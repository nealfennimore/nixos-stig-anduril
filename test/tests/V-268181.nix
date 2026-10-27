''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268181

  machine.succeed("grep -qE '^UMASK[[:space:]]+077$' /etc/login.defs")
''
