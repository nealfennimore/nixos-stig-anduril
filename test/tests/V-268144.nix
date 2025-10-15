''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268144
  # NOTE: No configured encrypted drive
  machine.fail("blkid | grep -q crypto_LUKS")

''