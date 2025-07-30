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

            # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268100
            # FIXME: params order
            machine.fail("auditctl -l | grep -qe '-a always,exit -F arch=b32 -S chmod,fchmod,fchmodat -F auid>=1000 -F auid!=unset -F key=perm_mod'")
            # FIXME: params order
            machine.fail("auditctl -l | grep -qe '-a always,exit -F arch=b64 -S chmod,fchmod,fchmodat -F auid>=1000 -F auid!=unset -F key=perm_mod'")

            # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268101
            machine.succeed("grep -q 'space_left_action = syslog' /etc/audit/auditd.conf")

            # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268102
            machine.succeed("grep -q 'admin_space_left_action = syslog' /etc/audit/auditd.conf")

            # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268103
            machine.succeed("grep -q 'space_left = 25%' /etc/audit/auditd.conf")

            # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268104
            machine.succeed("grep -q 'admin_space_left = 10%' /etc/audit/auditd.conf")

            # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268105
            machine.succeed("grep -q 'disk_full_action = HALT' /etc/audit/auditd.conf")

            # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268106
            machine.succeed("grep -q 'disk_error_action = HALT' /etc/audit/auditd.conf")

            # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268107
            machine.succeed("[[ $(systemctl is-active syslog-ng.service) == 'active' ]] && [[ $(systemctl is-enabled syslog-ng.service) == 'enabled' ]]")

            # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268108
            machine.succeed("grep -q log $(grep -E -o '([[:alnum:]]|/)+-syslog-ng\.conf' /etc/systemd/system/syslog-ng.service)")

            # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268109
            # NOTE: Failing as LDAP is run unencrypted locally
            machine.fail("grep -q 'transport(tls)' $(grep -E -o '([[:alnum:]]|/)+-syslog-ng\.conf' /etc/systemd/system/syslog-ng.service)")

            # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268110
            machine.succeed("grep -q 'log_group = root' /etc/audit/auditd.conf")

            # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268111
            machine.succeed("[[ -f /var/log/audit/audit.log ]]")

            # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268111
            machine.succeed("for i in $(find /var/log/audit -exec stat -c '%U' {} \;); do [[ $i == 'root' ]] || exit 1; done")

            # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268112
            machine.succeed("for i in $(find /var/log/audit -exec stat -c '%G' {} \;); do [[ $i == 'root' ]] || exit 1; done")

            # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268113
            machine.succeed("for i in $(find /var/log/audit -type d -exec stat -c '%a' {} \;); do [[ $i -eq 700 ]] || exit 1; done")

            # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268114
            machine.succeed("for i in $(find /var/log/audit -type f -exec stat -c '%a' {} \;); do [[ $i -eq 600 ]] || exit 1; done")

            # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268115
            machine.succeed("grep -q 'owner(root)' $(grep -E -o '([[:alnum:]]|/)+-syslog-ng\.conf' /etc/systemd/system/syslog-ng.service)")
            machine.succeed("grep -q 'dir_owner(root)' $(grep -E -o '([[:alnum:]]|/)+-syslog-ng\.conf' /etc/systemd/system/syslog-ng.service)")

            # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268116
            machine.succeed("grep -q 'group(root)' $(grep -E -o '([[:alnum:]]|/)+-syslog-ng\.conf' /etc/systemd/system/syslog-ng.service)")
            machine.succeed("grep -q 'dir_group(root)' $(grep -E -o '([[:alnum:]]|/)+-syslog-ng\.conf' /etc/systemd/system/syslog-ng.service)")

            # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268117
            machine.succeed("grep -q 'dir_perm(0750)' $(grep -E -o '([[:alnum:]]|/)+-syslog-ng\.conf' /etc/systemd/system/syslog-ng.service)")

            # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268118
            machine.succeed("grep -q 'perm(0640)' $(grep -E -o '([[:alnum:]]|/)+-syslog-ng\.conf' /etc/systemd/system/syslog-ng.service)")

            # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268119
            machine.succeed("auditctl -s | grep -qe 'loginuid_immutable 1 locked'")

            # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268120
            # NOTE: there's no files here in the VM
            machine.succeed("for i in $(find /etc/nixos -type f -exec stat -c '%a' {} \;); do [[ $i -eq 644 ]] || exit 1; done")

            # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268121
            machine.succeed("for i in $(find /etc/nixos -type d -exec stat -c '%a' {} \;); do [[ $i -eq 755 ]] || exit 1; done")

            # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268122
            machine.succeed("for i in $(find /etc/nixos -exec stat -c '%U' {} \;); do [[ $i == 'root' ]] || exit 1; done")

            # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268123
            machine.succeed("for i in $(find /etc/nixos -exec stat -c '%G' {} \;); do [[ $i == 'root' ]] || exit 1; done")

            # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268124
            machine.succeed("openssl x509 -text -in /etc/sssd/pki/sssd_auth_ca_db.pem | grep -qe 'CN=DoD Root CA 3'")

            # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268126
            machine.succeed("grep -q 'ucredit=-[0-9]{1}' /etc/security/pwquality.conf")

            # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268127
            machine.succeed("grep -q 'lcredit=-[0-9]{1}' /etc/security/pwquality.conf")

            # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268128
            machine.succeed("grep -q 'dcredit=-[0-9]{1}' /etc/security/pwquality.conf")

            # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268129
            machine.succeed("[[ $(grep -Eo 'difok=[0-9]{1}' /etc/security/pwquality.conf | awk -F= '{print $2}) -ge 8 ]]")

            # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268130
            machine.succeed("grep -q 'ENCRYPT_METHOD SHA512' /etc/login.defs")

            # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268131
            machine.fail("whereis telnet")

            # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268132
            machine.succeed("grep -q 'PASS_MIN_DAYS 1' /etc/login.defs")

            # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268133
            machine.succeed("grep -q 'PASS_MAX_DAYS 60' /etc/login.defs")

            # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268134
            machine.succeed("[[ $(grep -Eo 'minlen=[0-9]+' /etc/security/pwquality.conf | awk -F= '{print $2}) -ge 15 ]]")


          '';
        };
      };
    };
}
