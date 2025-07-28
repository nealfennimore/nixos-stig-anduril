{ lib, ... }:
{

  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268159
  services.openssh.enable = true;

  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268089
  services.openssh.setting.Ciphers = [
    "aes256-ctr"
    "aes192-ctr"
    "aes128-ctr"
  ];

  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268157
  services.openssh.macs = [
    "hmac-sha2-512"
    "hmac-sha2-256"
  ];

  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268176
  openssh.settings.UsePAM = "yes";

  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268083
  services.openssh.banner = lib.mkDefault ''
    You are accessing a U.S. Government (USG) Information System (IS) that is provided for USG-authorized use only.

    By using this IS (which includes any device attached to this IS), you consent to the following conditions:

    -The USG routinely intercepts and monitors communications on this IS for purposes including, but not limited to, penetration testing, COMSEC monitoring, network operations and defense, personnel misconduct (PM), law enforcement (LE), and counterintelligence (CI) investigations.
    -At any time, the USG may inspect and seize data stored on this IS.

    -Communications using, or data stored on, this IS are not private, are subject to routine monitoring, interception, and search, and may be disclosed or used for any USG-authorized purpose.

    -This IS includes security measures (e.g., authentication and access controls) to protect USG interests--not for your personal benefit or privacy.

    -Notwithstanding the above, using this IS does not constitute consent to PM, LE or CI investigative searching or monitoring of the content of privileged communications, or work product, related to personal representation or services by attorneys, psychotherapists, or clergy, and their assistants. Such communications and work product are private and confidential. See User Agreement for details.
  '';

  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268088
  services.openssh.logLevel = "VERBOSE";
}
