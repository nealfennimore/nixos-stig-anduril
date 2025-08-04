# NixOS STIG Anduril

[![.github/workflows/test.yml](https://github.com/nealfennimore/nixos-stig-anduril/actions/workflows/test.yml/badge.svg)](https://github.com/nealfennimore/nixos-stig-anduril/actions/workflows/test.yml)

Baseline NixOS configuration for implementing STIG controls for via [Anduril STIG](https://stigui.com/stigs/Anduril_NixOS_STIG)

## Usage

### Example

See [test](./test) for complete example implementation.

### Flake Import

```nix
{
  description = "Your Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    anduril-stig = {
      url = "github:nealfennimore/nixos-stig-anduril";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, anduril-stig }: {

    nixosConfigurations = {
      my_system = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = anduril-stig.modules ++ [
            ./configuration.nix
        ];
      };
    };
  };
}

```
