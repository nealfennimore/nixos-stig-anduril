''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268129

  machine.succeed("[[ $(grep -Eo 'difok=[0-9]{1}' /etc/security/pwquality.conf | awk -F= '{print $2}') -ge 8 ]]")

''
