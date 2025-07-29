{ ... }:
{
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268178
  services.sssd.config = ''
    [sssd]
    config_file_version = 2
    services = pam
    domains = shadowutils
  '';
}
