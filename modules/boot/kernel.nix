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

  boot.kernel.sysctl = {
    # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268141
    "net.ipv4.tcp_syncookies" = "1";

    # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268160
    "kernel.kptr_restrict" = 1;

    # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268161
    "kernel.randomize_va_space" = 2;
  };
}
