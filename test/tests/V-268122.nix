''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268122
  machine.succeed("for i in $(find /etc/nixos -exec stat -c '%U' {} \;); do [[ $i == 'root' ]] || exit 1; done")

''