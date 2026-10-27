''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268116

  machine.succeed("[[ -z \"$(find /var/log/journal -not -group systemd-journal)\" ]]")
''
