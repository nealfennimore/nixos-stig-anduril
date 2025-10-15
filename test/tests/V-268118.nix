''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268118
  machine.succeed("grep -q 'perm(0640)' $(grep -E -o '([[:alnum:]]|/)+-syslog-ng\.conf' /etc/systemd/system/syslog-ng.service)")

''