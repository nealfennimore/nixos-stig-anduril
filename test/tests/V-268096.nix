''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268096

  machine.succeed("auditctl -l | grep -qe '-a always,exit -F arch=b32 -S init_module,delete_module,finit_module -F auid>=1000 -F auid!=-1 -F key=module_chng'")

  machine.succeed("auditctl -l | grep -qe '-a always,exit -F arch=b64 -S init_module,delete_module,finit_module -F auid>=1000 -F auid!=-1 -F key=module_chng'")
''
