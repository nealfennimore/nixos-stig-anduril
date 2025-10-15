''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268135
  machine.succeed("awk -F ':' 'list[$3]++{print $1, $3}' /etc/passwd")

''