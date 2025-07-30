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
            machine.succeed("grep -qE 'ucredit=-[0-9]{1}' /etc/security/pwquality.conf")

            # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268127
            machine.succeed("grep -qE 'lcredit=-[0-9]{1}' /etc/security/pwquality.conf")

            # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268128
            machine.succeed("grep -qE 'dcredit=-[0-9]{1}' /etc/security/pwquality.conf")

            # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268129
            machine.succeed("[[ $(grep -Eo 'difok=[0-9]{1}' /etc/security/pwquality.conf | awk -F= '{print $2}') -ge 8 ]]")

            # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268130
            # NOTE: Test is different from fix in group
            machine.succeed("grep -q 'ENCRYPT_METHOD SHA256' /etc/login.defs")

            # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268131
            machine.fail("which telnet")

            # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268132
            machine.succeed("grep -q 'PASS_MIN_DAYS 1' /etc/login.defs")

            # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268133
            machine.succeed("grep -q 'PASS_MAX_DAYS 60' /etc/login.defs")

            # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268134
            machine.succeed("[[ $(grep -Eo 'minlen=[0-9]+' /etc/security/pwquality.conf | awk -F= '{print $2}') -ge 15 ]]")

            # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268135
            machine.succeed("awk -F ':' 'list[$3]++{print $1, $3}' /etc/passwd")

            # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268136
            machine.succeed("grep -q opencryptoki /tmp/current-system")

            # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268137
            machine.succeed("grep -q 'PermitRootLogin no' /etc/ssh/sshd_config")

            # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268138
            machine.fail("[[ 'L' == $(passwd -S root | awk '{print $2}') ]]")

            # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268139
            machine.succeed("[[ $(systemctl is-active usbguard.service) == 'active' ]] && [[ $(systemctl is-enabled usbguard.service) == 'enabled' ]]")

            # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268140
            # machine.succeed("find / -type d \( -perm -0002 -a ! -perm -1000 \) -print 2>/dev/null")

            # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268141
            machine.succeed("sysctl net.ipv4.tcp_syncookies | grep -q 'net.ipv4.tcp_syncookies = 1'")

            # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268142
            machine.succeed("[[ $(grep 'ClientAliveInterval' /etc/ssh/sshd_config | awk '{print $2}') -ge 600 ]]")

            # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268143
            machine.succeed("grep -q 'ClientAliveCountMax 1' /etc/ssh/sshd_config ")

            # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268144
            # NOTE: No configured encrypted drive
            machine.fail("blkid | grep -q crypto_LUKS")

            # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268145
            machine.succeed("grep -qE 'ocredit=-[0-9]{1}' /etc/security/pwquality.conf")

            # TODO: https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268146
            # TODO: https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268147


            # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268148
            # FIXME: params order
            machine.fail("auditctl -l | grep -qe '-a always,exit -F arch=b32 -S execve -C uid!=euid -F euid=0 -k execpriv'")
            # FIXME: params order
            machine.fail("auditctl -l | grep -qe '-a always,exit -F arch=b64 -S execve -C uid!=euid -F euid=0 -k execpriv'")
            # FIXME: params order
            machine.fail("auditctl -l | grep -qe '-a always,exit -F arch=b32 -S execve -C gid!=egid -F egid=0 -k execpriv'")
            # FIXME: params order
            machine.fail("auditctl -l | grep -qe '-a always,exit -F arch=b64 -S execve -C gid!=egid -F egid=0 -k execpriv'")

            # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268149
            machine.succeed("timedatectl show-timesync | grep -q 'usnogps.navy.mil'")

            # TODO: find
            machine.succeed("grep -q 'DEFAULT_HOME yes' /etc/login.defs")
            machine.succeed("grep -q 'SYS_UID_MIN  400' /etc/login.defs")
            machine.succeed("grep -q 'SYS_UID_MAX  999' /etc/login.defs")
            machine.succeed("grep -q 'UID_MIN      1000' /etc/login.defs")
            machine.succeed("grep -q 'UID_MAX      29999' /etc/login.defs")
            machine.succeed("grep -q 'SYS_GID_MIN  400' /etc/login.defs")
            machine.succeed("grep -q 'SYS_GID_MAX  999' /etc/login.defs")
            machine.succeed("grep -q 'GID_MIN      1000' /etc/login.defs")
            machine.succeed("grep -q 'GID_MAX      29999' /etc/login.defs")
            machine.succeed("grep -q 'TTYGROUP     tty' /etc/login.defs")
            machine.succeed("grep -q 'TTYPERM      0620' /etc/login.defs")

            # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268150
            machine.succeed("timedatectl show-timesync | grep -q 'PollIntervalMaxUSec=1min'")

            # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268151
            machine.succeed("timedatectl status | grep -q 'NTP service: active'")

            # TODO: https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268152

            # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268153
            machine.succeed("grep -q aide /tmp/current-system")
            machine.succeed("[[ -f /etc/aide/aide.conf ]]")

            # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268155
            machine.succeed("grep -q 'Defaults timestamp_timeout=0' /etc/sudoers")

            # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268156
            machine.succeed("grep -q '%wheel  ALL=(ALL:ALL)    SETENV: ALL' /etc/sudoers")

            # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268157
            machine.succeed("grep -q 'Macs hmac-sha2-512,hmac-sha2-256' /etc/ssh/sshd_config")

            # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268158
            machine.succeed("iptables -L | grep limit | grep -qe 'tcp dpt:ssh limit: above 1000000b/s mode srcip'")
            machine.succeed("iptables -L | grep limit | grep -qe 'tcp dpt:http limit: above 1000/min burst 5 mode srcip'")
            machine.succeed("iptables -L | grep limit | grep -qe 'tcp dpt:https limit: above 1000/min burst 5 mode srcip'")

            # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268159
            machine.succeed("[[ $(systemctl is-active sshd.service) == 'active' ]] && [[ $(systemctl is-enabled sshd.service) == 'enabled' ]]")

            # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268160
            machine.succeed("sysctl kernel.kptr_restrict | grep -q 'kernel.kptr_restrict = 1'")

            # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268161
            machine.succeed("sysctl kernel.randomize_va_space | grep -q 'kernel.randomize_va_space = 2'")

            # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268163
            # FIXME: params order
            machine.fail("auditctl -l | grep -qe '-a always,exit -F arch=b32 -S setxattr,fsetxattr,lsetxattr,removexattr,fremovexattr,lremovexattr -F auid>=1000 -F auid!=-1 -k perm_mod'")
            # FIXME: params order
            machine.fail("auditctl -l | grep -qe '-a always,exit -F arch=b32 -S setxattr,fsetxattr,lsetxattr,removexattr,fremovexattr,lremovexattr -F auid=0 -k perm_mod'")
            # FIXME: params order
            machine.fail("auditctl -l | grep -qe '-a always,exit -F arch=b64 -S setxattr,fsetxattr,lsetxattr,removexattr,fremovexattr,lremovexattr -F auid>=1000 -F auid!=-1 -k perm_mod'")
            # FIXME: params order
            machine.fail("auditctl -l | grep -qe '-a always,exit -F arch=b64 -S setxattr,fsetxattr,lsetxattr,removexattr,fremovexattr,lremovexattr -F auid=0 -k perm_mod'")

            # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268164
            # FIXME: params order
            machine.fail("auditctl -l | grep -qe '-a always,exit -F path=/run/current-system/sw/bin/usermod -F perm=x -F auid>=1000 -F auid!=unset -k privileged-usermod'")

            # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268165
            # FIXME: params order
            machine.fail("auditctl -l | grep -qe '-a always,exit -S all -F path=/run/current-system/sw/bin/chage -F perm=x -F auid>=1000 -F auid!=-1 -k privileged-chage'")
            # FIXME: params order
            machine.fail("auditctl -l | grep -qe '-a always,exit -S all -F path=/run/current-system/sw/bin/chcon -F perm=x -F auid>=1000 -F auid!=-1 -k perm_mod'")

            # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268166
            machine.succeed("auditctl -l | grep -qe '-w /var/log/lastlog -p wa -k logins'")

            # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268167
            machine.succeed("auditctl -l | grep -qe '-w /etc/sudoers -p wa -k identity'")
            machine.succeed("auditctl -l | grep -qe '-w /etc/passwd -p wa -k identity'")
            machine.succeed("auditctl -l | grep -qe '-w /etc/shadow -p wa -k identity'")
            machine.succeed("auditctl -l | grep -qe '-w /etc/gshadow -p wa -k identity'")
            machine.succeed("auditctl -l | grep -qe '-w /etc/group -p wa -k identity'")
            machine.succeed("auditctl -l | grep -qe '-w /etc/security/opasswd -p wa -k identity'")

            # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268168
            machine.succeed("grep -q 'fips=1' /proc/cmdline")

            # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268169
            machine.succeed("grep -q 'dictcheck=1' /etc/security/pwquality.conf")

            # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268170
            machine.succeed(" grep -q pam_pwquality /etc/pam.d/passwd")
            machine.succeed(" grep -q pam_pwquality /etc/pam.d/chpasswd")
            machine.succeed(" grep -q pam_pwquality /etc/pam.d/sudo")

            # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268171
            machine.succeed("[[ $(grep 'FAIL_DELAY' /etc/login.defs | awk '{print $2}') -ge 4 ]]")

            # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268172
            # NOTE: No desktop
            machine.fail("grep -q 'AutomaticLoginEnable=False' /etc/gdm/custom.conf")

            # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268173
            machine.succeed("[[ $(systemctl is-active apparmor.service) == 'active' ]] && [[ $(systemctl is-enabled apparmor.service) == 'enabled' ]]")

            # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268174
            machine.succeed("[[ $(grep 'INACTIVE' /etc/login.defs | awk -F= '{print $2}') -le 35 ]]")

            # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268175
            machine.succeed("for i in $(grep -Eo '\$[0-9]\$' /etc/shadow); do [[ $i == '$6$' ]] || exit 1; done")

            # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268176
            machine.succeed("sshd -G | grep -q 'usepam yes'")

            # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268177
            machine.succeed("grep -q 'pam_p11.so' /etc/pam.d/sudo")

            # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268178
            machine.succeed("grep -q 'offline_credentials_expiration = 1' /etc/sssd/sssd.conf")

            # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268179
            machine.succeed("grep -q 'cert_policy = ca,signature,ocsp_on, crl_auto;' /etc/pam_pkcs11/pam_pkcs11.conf")

            # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268180
            machine.succeed("nixos-version")
          '';
        };
      };
    };
}
