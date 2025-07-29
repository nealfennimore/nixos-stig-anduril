{ ... }:
{
  services.syslog-ng = {
    remote_host = "127.0.0.1";
    remote_port = "1111";
    remote_tls = false;
  };
}
