''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268114

  machine.succeed("for i in $(find /var/log/audit -type f -exec stat -c '%a' {} \\;); do [[ $i -eq 600 ]] || exit 1; done")

''
