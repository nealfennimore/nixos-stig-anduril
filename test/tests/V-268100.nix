''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268100
  # FIXME: params order
  machine.fail("auditctl -l | grep -qe '-a always,exit -F arch=b32 -S chmod,fchmod,fchmodat -F auid>=1000 -F auid!=unset -F key=perm_mod'")
  # FIXME: params order
  machine.fail("auditctl -l | grep -qe '-a always,exit -F arch=b64 -S chmod,fchmod,fchmodat -F auid>=1000 -F auid!=unset -F key=perm_mod'")

''
