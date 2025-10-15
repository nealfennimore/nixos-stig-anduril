''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268113
  machine.succeed("for i in $(find /var/log/audit -type d -exec stat -c '%a' {} \;); do [[ $i -eq 700 ]] || exit 1; done")

''