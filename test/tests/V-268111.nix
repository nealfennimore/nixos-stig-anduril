''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268111
  machine.succeed("for i in $(find /var/log/audit -exec stat -c '%U' {} \;); do [[ $i == 'root' ]] || exit 1; done")

''