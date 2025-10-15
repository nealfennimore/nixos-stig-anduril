''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268095
  machine.success("auditctl -l | grep -qe '-a always,exit -F arch=b32 -S unlink,rename,rmdir,unlinkat,renameat -F auid>=1000 -F auid!=-1 -F key=delete'")
  machine.success("auditctl -l | grep -qe '-a always,exit -F arch=b64 -S rename,rmdir,unlink,unlinkat,renameat -F auid>=1000 -F auid!=-1 -F key=delete'")
''
