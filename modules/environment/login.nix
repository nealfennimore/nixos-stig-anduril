{ lib, ... }:
{
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268130
  environment.etc."login.defs".text = lib.mkForce ''
    ENCRYPT_METHOD SHA256
  '';
}
