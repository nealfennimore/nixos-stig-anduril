''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268089
  machine.succeed("grep -q 'Ciphers aes256-ctr,aes192-ctr,aes128-ctr' /etc/ssh/sshd_config")

''
