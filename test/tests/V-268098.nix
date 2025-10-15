''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268098

  machine.succeed("auditctl -l | grep -qe '-a always,exit -F arch=b32 -S open,creat,truncate,ftruncate,openat,open_by_handle_at -F exit=-EACCES -F auid>=1000 -F auid!=-1 -F key=access'")

  machine.succeed("auditctl -l | grep -qe '-a always,exit -F arch=b32 -S open,creat,truncate,ftruncate,openat,open_by_handle_at -F exit=-EPERM -F auid>=1000 -F auid!=-1 -F key=access'")

  machine.succeed("auditctl -l | grep -qe '-a always,exit -F arch=b64 -S open,truncate,ftruncate,creat,openat,open_by_handle_at -F exit=-EACCES -F auid>=1000 -F auid!=-1 -F key=access'")

  machine.succeed("auditctl -l | grep -qe '-a always,exit -F arch=b64 -S open,truncate,ftruncate,creat,openat,open_by_handle_at -F exit=-EPERM -F auid>=1000 -F auid!=-1 -F key=access'")

''
