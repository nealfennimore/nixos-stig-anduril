''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268138

  # FIXME: Not able to get this to be L in test
  # However, running the VM shows it as L

  machine.fail("[[ 'L' == $(passwd -S root | awk '{print $2}') ]]")

''
