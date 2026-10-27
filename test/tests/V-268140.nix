''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268140

  machine.succeed("[[ -z \"$(find / -not -path '/proc/*' -type d \\( -perm -0002 -a ! -perm -1000 \\) -print 2>/dev/null)\" ]]")
''
