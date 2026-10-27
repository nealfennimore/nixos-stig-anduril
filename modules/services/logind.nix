{ lib, ... }:
{
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268086
  # 600 seconds is the maximum. A shorter timeout is allowed.
  services.logind.settings.Login = {
    IdleAction = lib.mkDefault "lock";
    IdleActionSec = lib.mkDefault 600;
  };
}
