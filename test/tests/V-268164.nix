''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268164
  machine.succeed("auditctl -l | grep -qe '-a always,exit -F path=/run/current-system/sw/bin/usermod -F perm=x -F auid>=1000 -F auid!=unset -F key=privileged-usermod'")

''
