{ ... }:
{
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268086
  services.logind.settings.Login = {
    IdleAction = "lock";
    IdleActionSec = 600;
  };
}
