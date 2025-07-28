{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268087
    vlock
    # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268090
    audit
  ];
}
