''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268108

  machine.succeed("grep -qiE '^URL[[:space:]]*=[[:space:]]*[^[:space:]]' /etc/systemd/journal-upload.conf")
''
