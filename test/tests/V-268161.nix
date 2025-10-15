''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268161
  machine.succeed("sysctl kernel.randomize_va_space | grep -q 'kernel.randomize_va_space = 2'")

''