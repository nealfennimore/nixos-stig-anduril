{ ... }:
{
  boot.kernelParams = [
    # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268168
    "fips=1"

    # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268092
    "audit=1"

    # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268093
    "audit_backlog_limit=8192"
  ];
}
