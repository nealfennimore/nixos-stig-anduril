''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268156

  machine.succeed("grep -q '%wheel' /etc/sudoers")

  machine.fail("grep '%wheel' /etc/sudoers | grep -q NOPASSWD")
''
