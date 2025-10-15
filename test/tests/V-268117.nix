''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268117

  machine.succeed("grep -q 'dir_perm(0750)' $(grep -E -o '([[:alnum:]]|/)+-syslog-ng\\.conf' /etc/systemd/system/syslog-ng.service)")

''
