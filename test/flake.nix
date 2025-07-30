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

          testScript = ''
            machine.wait_for_unit("default.target")
            machine.succeed("nix-store --query --requisites /run/current-system | cut -d- -f2- | sort | uniq > /tmp/current-system")
            machine.succeed("which iptables")

            machine.fail("auditctl -l | grep -qe '-a always,exit -F arch=b32 -S init_module,finit_module,delete_module -F auid>=1000 -F auid!=-1 -F key=module_chng'")
            machine.fail("auditctl -l | grep -qe '-a always,exit -F arch=b32 -S open,creat,truncate,ftruncate,openat,open_by_handle_at -F exit=-EACCES -F auid>=1000 -F auid!=unset -F key=access'")
            machine.fail("auditctl -l | grep -qe '-a always,exit -F arch=b32 -S open,creat,truncate,ftruncate,openat,open_by_handle_at -F exit=-EPERM -F auid>=1000 -F auid!=unset -F key=access'")
            machine.fail("auditctl -l | grep -qe '-a always,exit -F arch=b32 -S rename,unlink,rmdir,renameat,unlinkat -F auid>=1000 -F auid!=-1 -F key=delete'")
            machine.fail("auditctl -l | grep -qe '-a always,exit -F arch=b64 -S init_module,finit_module,delete_module -F auid>=1000 -F auid!=-1 -F key=module_chng'")
            machine.fail("auditctl -l | grep -qe '-a always,exit -F arch=b64 -S open,creat,truncate,ftruncate,openat,open_by_handle_at -F exit=-EACCES -F auid>=1000 -F auid!=unset -F key=access'")
            machine.fail("auditctl -l | grep -qe '-a always,exit -F arch=b64 -S open,creat,truncate,ftruncate,openat,open_by_handle_at -F exit=-EPERM -F auid>=1000 -F auid!=unset -F key=access'")
            machine.fail("auditctl -l | grep -qe '-a always,exit -F arch=b64 -S rename,unlink,rmdir,renameat,unlinkat -F auid>=1000 -F auid!=-1 -F key=delete'")
            machine.fail("echo -e 'Pass@1234567890\nPass@1234567890' | passwd 2>&1 | grep -q 'BAD PASSWORD'")
            machine.succeed("[[ $(dconf read '/org/gnome/desktop/session/idle-delay') == 'uint32 600' ]]")
            machine.succeed("auditctl -l | grep -qe '-a always,exit -F arch=b32 -S execve -C gid!=egid -F egid=0 -F key=execpriv'")
            machine.succeed("auditctl -l | grep -qe '-a always,exit -F arch=b32 -S execve -C uid!=euid -F euid=0 -F key=execpriv'")
            machine.succeed("auditctl -l | grep -qe '-a always,exit -F arch=b32 -S lchown,fchown,chown,fchownat -F auid>=1000 -F auid!=-1 -F key=perm_mod'")
            machine.succeed("auditctl -l | grep -qe '-a always,exit -F arch=b32 -S lchown,fchown,chown,fchownat -F auid>=1000 -F auid!=-1 -F key=perm_mod'")
            machine.succeed("auditctl -l | grep -qe '-a always,exit -F arch=b32 -S mount -F auid>=1000 -F auid!=-1 -F key=privileged-mount'")
            machine.succeed("auditctl -l | grep -qe '-a always,exit -F arch=b64 -S chown,fchown,lchown,fchownat -F auid>=1000 -F auid!=-1 -F key=perm_mod'")
            machine.succeed("auditctl -l | grep -qe '-a always,exit -F arch=b64 -S chown,fchown,lchown,fchownat -F auid>=1000 -F auid!=-1 -F key=perm_mod'")
            machine.succeed("auditctl -l | grep -qe '-a always,exit -F arch=b64 -S execve -C gid!=egid -F egid=0 -F key=execpriv'")
            machine.succeed("auditctl -l | grep -qe '-a always,exit -F arch=b64 -S execve -C uid!=euid -F euid=0 -F key=execpriv'")
            machine.succeed("auditctl -l | grep -qe '-a always,exit -F arch=b64 -S mount -F auid>=1000 -F auid!=-1 -F key=privileged-mount'")
            machine.succeed("auditctl -l | grep -qw cron")
            machine.succeed("echo -e 'Pass@1\nPass@1' | passwd 2>&1 | grep -q 'BAD PASSWORD'")
            machine.succeed("echo -e 'pass\npass' | passwd 2>&1 | grep -q 'BAD PASSWORD'")
            machine.succeed("echo -e 'Pass\nPass' | passwd 2>&1 | grep -q 'BAD PASSWORD'")
            machine.succeed("echo -e 'Pass1\nPass1' | passwd 2>&1 | grep -q 'BAD PASSWORD'")
            machine.succeed("for i in $(grep -E -o 'succeed_interval=[0-9]+' /etc/pam.d/login | grep -E -o '[0-9]+'); do (( $i >= 900 )) || exit 1; done")
            machine.succeed("grep -q 'Ciphers aes256-ctr,aes192-ctr,aes128-ctr' /etc/ssh/sshd_config")
            machine.succeed("grep -q 'LogLevel VERBOSE' /etc/ssh/sshd_config")
            machine.succeed("grep -q 'Macs hmac-sha2-512,hmac-sha2-256' /etc/ssh/sshd_config")
            machine.succeed("grep -q audit /tmp/current-system")
            machine.succeed("grep -q audit_backlog_limit=8192 /proc/cmdline")
            machine.succeed("grep -q audit=1 /proc/cmdline")
            machine.succeed("grep -q USG $(grep Banner /etc/ssh/sshd_config | awk '{print $2}')")
            machine.succeed("nix-store --query --requisites /run/current-system | cut -d- -f2- | sort | uniq | grep vlock")
          '';
        };
      };
    };
}
