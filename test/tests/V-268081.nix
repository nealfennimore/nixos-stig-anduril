''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268081

  machine.succeed("grep -q 'pam_faillock.so preauth' /etc/pam.d/login")

  machine.succeed("grep -q 'pam_faillock.so preauth' /etc/pam.d/sshd")

  machine.succeed("grep 'pam_faillock.so preauth' /etc/pam.d/login | grep -q 'deny=3'")

  machine.succeed("for i in $(grep 'pam_faillock.so preauth' /etc/pam.d/login | grep -E -o 'fail_interval=[0-9]+' | grep -E -o '[0-9]+'); do (( $i > 0 && $i <= 900 )) || exit 1; done")
''
