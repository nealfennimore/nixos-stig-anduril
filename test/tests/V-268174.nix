''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268174

  machine.succeed("[[ $(grep -i '^INACTIVE' /etc/default/useradd | awk -F= '{print $2}') -le 35 ]]")
''
