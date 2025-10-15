''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268163
  # FIXME: params order
  machine.fail("auditctl -l | grep -qe '-a always,exit -F arch=b32 -S setxattr,fsetxattr,lsetxattr,removexattr,fremovexattr,lremovexattr -F auid>=1000 -F auid!=-1 -k perm_mod'")
  # FIXME: params order
  machine.fail("auditctl -l | grep -qe '-a always,exit -F arch=b32 -S setxattr,fsetxattr,lsetxattr,removexattr,fremovexattr,lremovexattr -F auid=0 -k perm_mod'")
  # FIXME: params order
  machine.fail("auditctl -l | grep -qe '-a always,exit -F arch=b64 -S setxattr,fsetxattr,lsetxattr,removexattr,fremovexattr,lremovexattr -F auid>=1000 -F auid!=-1 -k perm_mod'")
  # FIXME: params order
  machine.fail("auditctl -l | grep -qe '-a always,exit -F arch=b64 -S setxattr,fsetxattr,lsetxattr,removexattr,fremovexattr,lremovexattr -F auid=0 -k perm_mod'")

''