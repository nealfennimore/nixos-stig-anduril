''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268086
  machine.succeed("[[ $(dconf read '/org/gnome/desktop/session/idle-delay') == 'uint32 600' ]]")

''
