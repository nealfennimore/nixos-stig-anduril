''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268177

  machine.succeed("grep -q 'pam_p11.so' /etc/pam.d/sudo")

''
