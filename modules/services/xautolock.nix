{ config, lib, ... }:
{
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268086
  # 10 minutes is the maximum. Sites can use a shorter time or a different locker.
  services.xserver.xautolock = {
    enable = lib.mkDefault true;
    time = lib.mkDefault 10;
    locker = lib.mkDefault "${lib.getExe' config.systemd.package "loginctl"} lock-session";
  };
}
