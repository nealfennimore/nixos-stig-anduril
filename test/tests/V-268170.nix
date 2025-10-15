''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268170

  machine.succeed(" grep -q pam_pwquality /etc/pam.d/passwd")

  machine.succeed(" grep -q pam_pwquality /etc/pam.d/chpasswd")

  machine.succeed(" grep -q pam_pwquality /etc/pam.d/sudo")

''
