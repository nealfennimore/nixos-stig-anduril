''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268109

  # NOTE: Failing as syslog is run unencrypted locally
  machine.fail("grep -q 'transport(tls)' $(grep -E -o '([[:alnum:]]|/)+-syslog-ng\\.conf' /etc/systemd/system/syslog-ng.service)")

''
