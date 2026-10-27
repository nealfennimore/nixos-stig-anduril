{ config, lib, ... }:
{
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268153
  services.cron = {
    # Plain assignment on purpose: nixpkgs sets services.cron.enable with mkDefault,
    # so a second mkDefault would conflict when the job list is empty.
    enable = true;
    systemCronJobs = lib.mkDefault [
      "00 0 * * 0\troot\taide -c /etc/aide.conf --check | /bin/mail -s \"aide integrity check run for ${config.networking.hostName}\" root@notareal.email"
    ];
  };
}
