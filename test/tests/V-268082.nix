''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268082

  machine.succeed("grep -q USG /etc/static/issue")
''
