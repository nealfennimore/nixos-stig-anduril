''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268134
  machine.succeed("[[ $(grep -Eo 'minlen=[0-9]+' /etc/security/pwquality.conf | awk -F= '{print $2}') -ge 15 ]]")

''