''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268167

  machine.succeed("auditctl -l | grep -qe '-w /etc/sudoers -p wa -k identity'")

  machine.succeed("auditctl -l | grep -qe '-w /etc/passwd -p wa -k identity'")

  machine.succeed("auditctl -l | grep -qe '-w /etc/shadow -p wa -k identity'")

  machine.succeed("auditctl -l | grep -qe '-w /etc/gshadow -p wa -k identity'")

  machine.succeed("auditctl -l | grep -qe '-w /etc/group -p wa -k identity'")

  machine.succeed("auditctl -l | grep -qe '-w /etc/security/opasswd -p wa -k identity'")


''
