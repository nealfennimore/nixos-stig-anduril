''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268149
  machine.succeed("timedatectl show-timesync | grep -q 'usnogps.navy.mil'")

  # TODO: find
  machine.succeed("grep -q 'DEFAULT_HOME yes' /etc/login.defs")
  machine.succeed("grep -q 'SYS_UID_MIN  400' /etc/login.defs")
  machine.succeed("grep -q 'SYS_UID_MAX  999' /etc/login.defs")
  machine.succeed("grep -q 'UID_MIN      1000' /etc/login.defs")
  machine.succeed("grep -q 'UID_MAX      29999' /etc/login.defs")
  machine.succeed("grep -q 'SYS_GID_MIN  400' /etc/login.defs")
  machine.succeed("grep -q 'SYS_GID_MAX  999' /etc/login.defs")
  machine.succeed("grep -q 'GID_MIN      1000' /etc/login.defs")
  machine.succeed("grep -q 'GID_MAX      29999' /etc/login.defs")
  machine.succeed("grep -q 'TTYGROUP     tty' /etc/login.defs")
  machine.succeed("grep -q 'TTYPERM      0620' /etc/login.defs")

''