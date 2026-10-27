''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268122

  machine.succeed("for i in $(find /etc/audit -exec stat -L -c '%U' {} \\;); do [[ $i == 'root' ]] || exit 1; done")

  machine.succeed("for i in $(find /etc/systemd/system -follow -iname 'audit*service' -exec stat -c '%U' {} \\;); do [[ $i == 'root' ]] || exit 1; done")
''
