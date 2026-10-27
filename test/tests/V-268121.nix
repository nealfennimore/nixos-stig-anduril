''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268121

  machine.succeed("for i in $(find -L /etc/audit -type d -exec stat -L -c '%a' {} \\;); do (( (8#$i & 8#022) == 0 )) || exit 1; done")
''
