''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268148
  # FIXME: params order
  machine.fail("auditctl -l | grep -qe '-a always,exit -F arch=b32 -S execve -C uid!=euid -F euid=0 -k execpriv'")
  # FIXME: params order
  machine.fail("auditctl -l | grep -qe '-a always,exit -F arch=b64 -S execve -C uid!=euid -F euid=0 -k execpriv'")
  # FIXME: params order
  machine.fail("auditctl -l | grep -qe '-a always,exit -F arch=b32 -S execve -C gid!=egid -F egid=0 -k execpriv'")
  # FIXME: params order
  machine.fail("auditctl -l | grep -qe '-a always,exit -F arch=b64 -S execve -C gid!=egid -F egid=0 -k execpriv'")

''