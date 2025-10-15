''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268169
  machine.succeed("grep -q 'dictcheck=1' /etc/security/pwquality.conf")

''