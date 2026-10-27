{ config, lib, ... }:
{
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268086
  services.xserver.xautolock = {
    enable = true;
    time = 10;
    locker = "${lib.getExe' config.systemd.package "loginctl"} lock-session";
  };
}
