''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268130

  # NOTE: Test is different from fix in group
  machine.succeed("grep -q 'ENCRYPT_METHOD SHA256' /etc/login.defs")

''