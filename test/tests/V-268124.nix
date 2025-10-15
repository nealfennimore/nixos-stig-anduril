''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268124

  machine.succeed("openssl x509 -text -in /etc/sssd/pki/sssd_auth_ca_db.pem | grep -qe 'CN=DoD Root CA 3'")

''
