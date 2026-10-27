''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268082

  machine.succeed("tail -n+3 /etc/issue | grep -q 'You are accessing a U.S. Government (USG) Information System (IS)'")
''
