''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268091

  machine.succeed("auditctl -l | grep -qe '-a always,exit -F arch=b64 -S execve -C uid!=euid -F euid=0 -F key=execpriv'")

  machine.succeed("auditctl -l | grep -qe '-a always,exit -F arch=b32 -S execve -C uid!=euid -F euid=0 -F key=execpriv'")

  machine.succeed("auditctl -l | grep -qe '-a always,exit -F arch=b64 -S execve -C gid!=egid -F egid=0 -F key=execpriv'")

  machine.succeed("auditctl -l | grep -qe '-a always,exit -F arch=b32 -S execve -C gid!=egid -F egid=0 -F key=execpriv'")


''
