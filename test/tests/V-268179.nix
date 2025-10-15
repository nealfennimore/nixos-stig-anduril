''
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268179

  machine.succeed("grep -q 'cert_policy = ca,signature,ocsp_on, crl_auto;' /etc/pam_pkcs11/pam_pkcs11.conf")

''
