''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268157
  machine.succeed("grep -q 'Macs hmac-sha2-512,hmac-sha2-256' /etc/ssh/sshd_config")

''