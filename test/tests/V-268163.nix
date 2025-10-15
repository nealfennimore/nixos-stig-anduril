''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268163

  machine.succeed("auditctl -l | grep -qe '-a always,exit -F arch=b32 -S setxattr,lsetxattr,fsetxattr,removexattr,lremovexattr,fremovexattr -F auid>=1000 -F auid!=-1 -F key=perm_mod'")

  machine.succeed("auditctl -l | grep -qe '-a always,exit -F arch=b32 -S setxattr,lsetxattr,fsetxattr,removexattr,lremovexattr,fremovexattr -F auid=0 -F key=perm_mod'")

  machine.succeed("auditctl -l | grep -qe '-a always,exit -F arch=b64 -S setxattr,lsetxattr,fsetxattr,removexattr,lremovexattr,fremovexattr -F auid>=1000 -F auid!=-1 -F key=perm_mod'")

  machine.succeed("auditctl -l | grep -qe '-a always,exit -F arch=b64 -S setxattr,lsetxattr,fsetxattr,removexattr,lremovexattr,fremovexattr -F auid=0 -F key=perm_mod'")


''
