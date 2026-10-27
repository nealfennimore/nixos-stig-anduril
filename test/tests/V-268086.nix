''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268086

  machine.succeed("[[ $(dconf read '/org/gnome/desktop/session/idle-delay') == 'uint32 600' ]]")

  machine.succeed("grep -qE '^IdleAction[[:space:]]*=[[:space:]]*lock' /etc/systemd/logind.conf")

  machine.succeed("grep -qE '^IdleActionSec[[:space:]]*=[[:space:]]*600' /etc/systemd/logind.conf")

  # xautolock is a user service, so it only runs inside a graphical session. Check the unit definition.

  machine.succeed("grep -q -- '-time 10' /etc/systemd/user/xautolock.service")
''
