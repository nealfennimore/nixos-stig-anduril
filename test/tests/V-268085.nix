''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268085

  machine.succeed("grep -q 'pam_limits.so' /etc/pam.d/login")

  machine.succeed("grep -qF '* hard maxlogins 10' $(grep -o 'conf=[^ ]*limits.conf' /etc/pam.d/login | head -1 | cut -d= -f2)")
''
