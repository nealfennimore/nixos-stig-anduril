''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268158
  machine.succeed("iptables -L | grep limit | grep -qe 'tcp dpt:ssh limit: above 1000000b/s mode srcip'")
  machine.succeed("iptables -L | grep limit | grep -qe 'tcp dpt:http limit: above 1000/min burst 5 mode srcip'")
  machine.succeed("iptables -L | grep limit | grep -qe 'tcp dpt:https limit: above 1000/min burst 5 mode srcip'")

''