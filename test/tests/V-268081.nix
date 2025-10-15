''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268081
  machine.succeed("grep -q pam_faillock /etc/pam.d/login")
  machine.succeed("for i in $(grep pam_faillock /etc/pam.d/login | grep -E -o 'fail_interval=[0-9]+' | grep -E -o '[0-9]+'); do (( $i >= 900 )) || exit 1; done")
''
