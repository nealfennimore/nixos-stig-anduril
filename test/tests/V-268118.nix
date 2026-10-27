''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268118

  machine.succeed("[[ -z \"$(find /var/log/journal -type f -perm -640 -not -perm 640)\" ]]")
''
