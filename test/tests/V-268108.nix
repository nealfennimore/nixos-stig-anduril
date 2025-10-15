''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268108
  machine.succeed("grep -q log $(grep -E -o '([[:alnum:]]|/)+-syslog-ng\.conf' /etc/systemd/system/syslog-ng.service)")

''