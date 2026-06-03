{
  config,
  lib,
  ...
}:
lib.mkIf config.services.cron.enable {
  systemd.tmpfiles.rules = [
    "d /var/cron/tabs       0700 root root -"
    "f /var/cron/cron.allow 0600 root root -"
    "f /var/cron/cron.deny  0600 root root -"
  ];

  # Audit rules will fail if the cron files do not already exist
  # Ensure that the audit rules will only load after the tmpfiles have been created
  systemd.services.audit-rules-nixos.after = [ "systemd-tmpfiles-setup.service" ];
}
