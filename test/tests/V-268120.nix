''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268120

  machine.succeed("for i in $(find -L /etc/audit -type f -exec stat -L -c '%a' {} \\;); do (( (8#$i & 8#333) == 0 )) || exit 1; done")

  machine.succeed("for i in $(find -L /etc/systemd/system -iname 'audit*' -type f -exec stat -L -c '%a' {} \\;); do (( (8#$i & 8#333) == 0 )) || exit 1; done")
''
