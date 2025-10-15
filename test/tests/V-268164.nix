''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268164
  # FIXME: params order
  machine.fail("auditctl -l | grep -qe '-a always,exit -F path=/run/current-system/sw/bin/usermod -F perm=x -F auid>=1000 -F auid!=unset -k privileged-usermod'")

''