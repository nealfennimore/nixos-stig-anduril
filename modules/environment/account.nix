{
  config,
  lib,
  utils,
  ...
}:
{
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268174
  # NixOS defines this file with `source`, so `text` must be forced (mkDefault would lose to it).
  # Keep the NixOS defaults (GROUP, HOME, SHELL) and add INACTIVE.
  environment.etc."default/useradd".text = lib.mkForce ''
    GROUP=100
    HOME=${config.users.defaultUserHome}
    SHELL=${utils.toShellPath config.users.defaultUserShell}
    INACTIVE=35
  '';
}
