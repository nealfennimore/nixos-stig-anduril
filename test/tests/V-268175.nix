''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268175
  machine.succeed("for i in $(grep -Eo '\$[0-9]\$' /etc/shadow); do [[ $i == '$6$' ]] || exit 1; done")

''