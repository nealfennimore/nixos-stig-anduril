''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268116

  machine.succeed("grep -q 'group(root)' $(grep -E -o '([[:alnum:]]|/)+-syslog-ng\\.conf' /etc/systemd/system/syslog-ng.service)")

  machine.succeed("grep -q 'dir_group(root)' $(grep -E -o '([[:alnum:]]|/)+-syslog-ng\\.conf' /etc/systemd/system/syslog-ng.service)")

''
