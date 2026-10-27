{ config, lib, ... }:
let
  upload = config.services.journald.upload;
in
{
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268107
  services.journald.audit = lib.mkDefault true;

  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268108
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268109
  # The consumer must set:
  #   services.journald.upload.settings.Upload.URL
  #   services.journald.upload.settings.Upload.TrustedCertificateFile
  # Evaluation fails if URL is not set.
  services.journald.upload.enable = lib.mkDefault true;

  assertions = [
    {
      assertion =
        upload.enable
        -> (
          upload.settings.Upload.TrustedCertificateFile != null
          && upload.settings.Upload.TrustedCertificateFile != "all"
        );
      message = "V-268109: services.journald.upload.settings.Upload.TrustedCertificateFile must be set to a CA file and must not be \"all\".";
    }
  ];
}
