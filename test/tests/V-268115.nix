''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268115

  machine.succeed("[[ -z \"$(find /var/log/journal -not -user root)\" ]]")
''
