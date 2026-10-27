{ ... }:
{
  # NixOS generates /etc/login.defs from security.loginDefs.settings.
  # Set the STIG values there so the NixOS defaults (UID ranges, TTYGROUP, ...) stay intact.
  security.loginDefs.settings = {
    # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268130
    ENCRYPT_METHOD = "SHA512";

    # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268132
    PASS_MIN_DAYS = "1";

    # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268133
    PASS_MAX_DAYS = "180";

    # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268171
    FAIL_DELAY = "4";

    # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268181
    UMASK = "077";
  };
}
