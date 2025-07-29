{
  description = "Anduril NixOS STIG";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    { ... }:
    {
      modules = [
        ./modules
      ];
    };
}
