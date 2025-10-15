''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268092
    machine.succeed("grep -q audit=1 /proc/cmdline")
''
