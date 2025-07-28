{ ... }:
{
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268078
  networking.firewall.enable = true;

  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268158
  networking.firewall.extraCommands = ''
    ip46tables --append INPUT --protocol tcp --dport 22 --match hashlimit --hashlimit-name stig_byte_limit --hashlimit-mode srcip --hashlimit-above 1000000b/second --jump nixos-fw-refuse
    ip46tables --append INPUT --protocol tcp --dport 80 --match hashlimit --hashlimit-name stig_conn_limit --hashlimit-mode srcip --hashlimit-above 1000/minute --jump nixos-fw-refuse
    ip46tables --append INPUT --protocol tcp --dport 443 --match hashlimit --hashlimit-name stig_conn_limit --hashlimit-mode srcip --hashlimit-above 1000/minute --jump nixos-fw-refuse
  '';

}
