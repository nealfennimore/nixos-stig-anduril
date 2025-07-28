{ ... }:
{
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268154
  nix.settings.require-sigs = true;

  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268152
  nix.settings.allowed-users = [
    "root"
    "@wheel"
  ];
}
