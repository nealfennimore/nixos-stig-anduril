''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268117

  machine.succeed("[[ -z \"$(find /var/log/journal -type d -perm -2755 -not -perm 2755)\" ]]")
''
