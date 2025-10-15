''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268087

  machine.succeed("nix-store --query --requisites /run/current-system | cut -d- -f2- | sort | uniq | grep vlock")
''
