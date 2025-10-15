''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268138
  machine.succeed("[[ 'L' == $(passwd -S root | awk '{print $2}') ]]")

''
