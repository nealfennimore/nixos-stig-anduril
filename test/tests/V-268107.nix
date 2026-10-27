''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268107

  machine.succeed("[[ $(systemctl is-active systemd-journald.service) == 'active' ]]")

  machine.succeed("grep -qE '^Audit=(yes|true)' /etc/systemd/journald.conf")
''
