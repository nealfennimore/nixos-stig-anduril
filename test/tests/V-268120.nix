''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268120

  # NOTE: there's no files here in the VM
  machine.succeed("for i in $(find /etc/nixos -type f -exec stat -c '%a' {} \\;); do [[ $i -eq 644 ]] || exit 1; done")

''