{
  description = "Anduril NixOS STIG";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      nixos-generators,
    }:
    let
      outer-flake = import ../flake.nix;
      modules = [
        nixos-generators.nixosModules.all-formats
        ./modules
      ]
      ++ (outer-flake.outputs { }).modules;
    in
    {
      nixosConfigurations."base" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs;
        };
        modules = modules;
      };

      checks."x86_64-linux" = {
        machine-test = inputs.nixpkgs.legacyPackages."x86_64-linux".testers.runNixOSTest {
          name = "audit-controls";
          nodes.machine =
            { ... }:
            {
              imports = modules;
            };
          node.pkgsReadOnly = false;

          testScript =
            let
              lib = nixpkgs.lib;
            in
            ''
              machine.wait_for_unit("default.target")
              machine.succeed("nix-store --query --requisites /run/current-system | cut -d- -f2- | sort | uniq > /tmp/current-system")

              machine.fail("echo -e 'Pass@1234567890\nPass@1234567890' | passwd 2>&1 | grep -q 'BAD PASSWORD'")
              machine.succeed("echo -e 'Pass@1\nPass@1' | passwd 2>&1 | grep -q 'BAD PASSWORD'")
              machine.succeed("echo -e 'pass\npass' | passwd 2>&1 | grep -q 'BAD PASSWORD'")
              machine.succeed("echo -e 'Pass\nPass' | passwd 2>&1 | grep -q 'BAD PASSWORD'")
              machine.succeed("echo -e 'Pass1\nPass1' | passwd 2>&1 | grep -q 'BAD PASSWORD'")
            ''
            + lib.strings.concatMapStringsSep "\n" (
              f: builtins.replaceStrings [ "''" "\n  " ] [ "" "" ] (lib.strings.fileContents f)
            ) (lib.fileset.toList ./tests);

        };
      };
    };
}
