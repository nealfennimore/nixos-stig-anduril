''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268078

  machine.succeed("iptables -L | grep -q nixos-fw-log-refuse")

  # NOTE: nixpkgs does not ship firewall-panic / firewall-panic-off. The check is only

  # a finding when the rule is missing AND the panic commands are missing.
''
