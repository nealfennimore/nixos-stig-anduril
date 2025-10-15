''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268099

  machine.succeed("auditctl -l | grep -qe '-a always,exit -F arch=b32 -S lchown,fchown,chown,fchownat -F auid>=1000 -F auid!=-1 -F key=perm_mod'")

  machine.succeed("auditctl -l | grep -qe '-a always,exit -F arch=b64 -S chown,fchown,lchown,fchownat -F auid>=1000 -F auid!=-1 -F key=perm_mod'")

''
