''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268084

  machine.succeed("DCONF_PROFILE=gdm dconf read /org/gnome/login-screen/banner-message-text | grep -q 'You are accessing a U.S. Government (USG) Information System (IS)'")
''
