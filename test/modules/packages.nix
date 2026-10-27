{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    openssl
    opensc
    # passwd is only installed by NixOS when users.mutableUsers = true
    shadow
  ];
}
