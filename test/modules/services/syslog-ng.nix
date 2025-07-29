{ ... }:
{
  services.syslog-ng = {
    remote_hosts = [ ''"127.0.0.1" port(1111)'' ];
    remote_tls = false;
  };
}
