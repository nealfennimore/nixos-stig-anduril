{ lib, ... }:
{
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268149
  networking.timeServers = lib.mkDefault [
    "tick.usnogps.navy.mil"
    "tock.usnogps.navy.mil"
  ];

}
