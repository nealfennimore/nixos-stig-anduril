''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268112
  machine.succeed("for i in $(find /var/log/audit -exec stat -c '%G' {} \;); do [[ $i == 'root' ]] || exit 1; done")

''