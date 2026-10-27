''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268109

  machine.succeed("grep -qiE '^TrustedCertificateFile[[:space:]]*=[[:space:]]*[^[:space:]]' /etc/systemd/journal-upload.conf")

  machine.fail("grep -qiE '^TrustedCertificateFile[[:space:]]*=[[:space:]]*all[[:space:]]*$' /etc/systemd/journal-upload.conf")
''
