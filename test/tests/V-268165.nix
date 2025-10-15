''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268165
  # FIXME: params order
  machine.fail("auditctl -l | grep -qe '-a always,exit -S all -F path=/run/current-system/sw/bin/chage -F perm=x -F auid>=1000 -F auid!=-1 -k privileged-chage'")
  # FIXME: params order
  machine.fail("auditctl -l | grep -qe '-a always,exit -S all -F path=/run/current-system/sw/bin/chcon -F perm=x -F auid>=1000 -F auid!=-1 -k perm_mod'")

''