''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268115
  machine.succeed("grep -q 'owner(root)' $(grep -E -o '([[:alnum:]]|/)+-syslog-ng\.conf' /etc/systemd/system/syslog-ng.service)")
  machine.succeed("grep -q 'dir_owner(root)' $(grep -E -o '([[:alnum:]]|/)+-syslog-ng\.conf' /etc/systemd/system/syslog-ng.service)")

''