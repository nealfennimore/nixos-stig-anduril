{ ... }:
{
  # Remote destination for V-268108 / V-268109. The host is not reachable
  # from the test VM; the tests only inspect the generated configuration.
  services.journald.upload.settings.Upload = {
    URL = "https://logs.example.invalid:19532";
    TrustedCertificateFile = "/etc/ssl/certs/ca-certificates.crt";
  };
}
