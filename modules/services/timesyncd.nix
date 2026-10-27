{ lib, ... }:
{
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268151
  services.timesyncd.enable = lib.mkForce true;

  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268150
  # 60 is the maximum. A smaller interval is allowed.
  services.timesyncd.extraConfig = lib.mkDefault ''
    PollIntervalMaxSec=60
  '';

}
