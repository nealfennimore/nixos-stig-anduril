{ ... }:
{
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268080
  security.auditd.enable = true;
  security.audit.enable = true;

  security.audit.rules = [
    # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268091
    "-a always,exit -F arch=b64 -S execve -C uid!=euid -F euid=0 -k execpriv"
    "-a always,exit -F arch=b32 -S execve -C uid!=euid -F euid=0 -k execpriv"
    "-a always,exit -F arch=b32 -S execve -C gid!=egid -F egid=0 -k execpriv "
    "-a always,exit -F arch=b64 -S execve -C gid!=egid -F egid=0 -k execpriv "

    # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268094
    "-a always,exit -F arch=b32 -S mount -F auid>=1000 -F auid!=unset -k privileged-mount"
    "-a always,exit -F arch=b64 -S mount -F auid>=1000 -F auid!=unset -k privileged-mount"

    # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268095
    "-a always,exit -F arch=b32 -S rename,unlink,rmdir,renameat,unlinkat -F auid>=1000 -F auid!=unset -k delete"
    "-a always,exit -F arch=b64 -S rename,unlink,rmdir,renameat,unlinkat -F auid>=1000 -F auid!=unset -k delete"

    # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268096
    "-a always,exit -F arch=b32 -S init_module,finit_module,delete_module -F auid>=1000 -F auid!=unset -k module_chng"
    "-a always,exit -F arch=b64 -S init_module,finit_module,delete_module -F auid>=1000 -F auid!=unset -k module_chng"

    # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268097
    "-w /var/cron/tabs/ -p wa -k services"
    "-w /var/cron/cron.allow -p wa -k services"
    "-w /var/cron/cron.deny -p wa -k services"

    # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268098
    "-a always,exit -F arch=b32 -S open,creat,truncate,ftruncate,openat,open_by_handle_at -F exit=-EACCES -F auid>=1000 -F auid!=unset -F key=access"
    "-a always,exit -F arch=b32 -S open,creat,truncate,ftruncate,openat,open_by_handle_at -F exit=-EPERM -F auid>=1000 -F auid!=unset -F key=access"
    "-a always,exit -F arch=b64 -S open,creat,truncate,ftruncate,openat,open_by_handle_at -F exit=-EACCES -F auid>=1000 -F auid!=unset -F key=access"
    "-a always,exit -F arch=b64 -S open,creat,truncate,ftruncate,openat,open_by_handle_at -F exit=-EPERM -F auid>=1000 -F auid!=unset -F key=access"

    # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268099
    "-a always,exit -F arch=b32 -S lchown,fchown,chown,fchownat -F auid>=1000 -F auid!=unset -F key=perm_mod"
    "-a always,exit -F arch=b64 -S chown,fchown,lchown,fchownat -F auid>=1000 -F auid!=unset -F key=perm_mod"

    # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268100
    "-a always,exit -F arch=b32 -S chmod,fchmod,fchmodat -F auid>=1000 -F auid!=unset -k perm_mod"
    "-a always,exit -F arch=b64 -S chmod,fchmod,fchmodat -F auid>=1000 -F auid!=unset -k perm_mod"
  ];

  environment.etc."audit/auditd.conf".text = [
    # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268101
    ''
      space_left_action = syslog
    ''

    # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268102
    ''
      admin_space_left_action = syslog
    ''

    # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268103
    ''
      space_left = 25%
    ''

    # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268104
    ''
      admin_space_left = 10%
    ''

    # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268105
    ''
      disk_full_action = HALT
    ''

    # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268106
    ''
      disk_error_action = HALT
    ''

    # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268110
    ''
      log_group = root
    ''
  ];

}
