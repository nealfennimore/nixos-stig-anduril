{ ... }:
{
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268151
  services.timesyncd.enable = true;

  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268150
  services.timesyncd.extraConfig = ''
    PollIntervalMaxSec=60
  '';

}
