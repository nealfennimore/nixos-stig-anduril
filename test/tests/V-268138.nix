''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268138

  # "L" or "NP" from passwd -S means the shadow password field is locked (starts with ! or *) or empty.

  # Read the field directly so the test does not depend on the passwd binary being installed.

  machine.succeed("[[ $(getent shadow root | cut -d: -f2) =~ ^(!|[*]|$) ]]")
''
