''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268121
  machine.succeed("for i in $(find /etc/nixos -type d -exec stat -c '%a' {} \;); do [[ $i -eq 755 ]] || exit 1; done")

''