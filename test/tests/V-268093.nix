''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268093

  machine.succeed("grep -q audit_backlog_limit=8192 /proc/cmdline")

  machine.succeed("[[ $(auditctl -s | grep -o 'backlog_limit [0-9]*' | awk '{print $2}') -ge 8192 ]]")
''
