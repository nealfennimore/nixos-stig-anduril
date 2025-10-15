''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268160

  machine.succeed("sysctl kernel.kptr_restrict | grep -q 'kernel.kptr_restrict = 1'")

''
