{ ... }:
{
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268107
  services.syslog-ng.enable = true;

  services.syslog-ng.extraConfig =
    # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268108
    ''
      source s_local { system(); internal(); };

      destination d_network {
        syslog(
        "<remote-logging-server>" port(<port>)
      };

      log { source(s_local); destination(d_network); };
    ''

    # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268109
    ++ ''
      destination d_network {
       syslog(
        "<remote-logging-server>" port(<port>)
        transport(tls)
        tls(
         cert-file("/var/syslog-ng/certs.d/certificate.crt")
         key-file("/var/syslog-ng/certs.d/certificate.key")
         ca-file("/var/syslog-ng/certs.d/cert-bundle.crt")
         peer-verify(yes)
        )
       );
      };

      log { source(s_local); destination(d_local); destination(d_network); };
    ''
    # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268115
    ++ ''
      options {
        owner(root);
        dir_owner(root);
      };
    ''
    # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268116
    ++ ''
      options {
        group(root);
        dir_group(root);
      };
    ''
    # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268117
    ++ ''
      options {
        dir_perm(0750);
      };
    ''
    # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268118
    ++ ''
      options {
        perm(0640);
      };
    ''
}
