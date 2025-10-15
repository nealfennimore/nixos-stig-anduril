''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268123
  machine.succeed("for i in $(find /etc/nixos -exec stat -c '%G' {} \;); do [[ $i == 'root' ]] || exit 1; done")

''