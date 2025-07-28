{ lib, ... }:
{
  # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268081
  security.pam.services =
    let
      pamfile = ''
        auth required pam_faillock.so preauth silent audit deny=3 fail_interval=900 unlock_time=0
        auth sufficient pam_unix.so nullok try_first_pass
        auth [default=die] pam_faillock.so authfail audit deny=3 fail_interval=900 unlock_time=0
        auth sufficient pam_faillock.so authsucc

        account required pam_faillock.so
      '';
    in
    {
      login.text = lib.mkDefault pamfile;
      sshd.text = lib.mkDefault pamfile;
    };
}
