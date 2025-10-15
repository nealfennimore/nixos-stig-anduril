''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268094

  machine.succeed("auditctl -l | grep -qe '-a always,exit -F arch=b32 -S mount -F auid>=1000 -F auid!=-1 -F key=privileged-mount'")

  machine.succeed("auditctl -l | grep -qe '-a always,exit -F arch=b64 -S mount -F auid>=1000 -F auid!=-1 -F key=privileged-mount'")
''
