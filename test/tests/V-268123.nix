''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268123

  machine.succeed("for i in $(find /etc/audit -exec stat -L -c '%G' {} \\;); do [[ $i == 'root' ]] || exit 1; done")

  machine.succeed("for i in $(find /etc/systemd/system -follow -iname 'audit*service' -exec stat -c '%G' {} \\;); do [[ $i == 'root' ]] || exit 1; done")
''
