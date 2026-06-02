{
  config,
  lib,
  pkgs,
  ...
}:
let
  auditctl = lib.getExe' config.security.audit.package "auditctl";

  # Just the rule directives (prefixed with a reset), without the AUDIT_SET
  # control lines the upstream module prepends — see below.
  auditRulesFile = pkgs.writeText "audit-stig-test.rules" (
    lib.concatLines ([ "-D" ] ++ config.security.audit.rules)
  );
in
{
  # Test-only workaround for loading the audit policy inside the NixOS test VM.
  # The upstream audit-rules-nixos.service cannot load our rules here for two
  # reasons, neither of which reflects the real target system:
  #
  #   1. audit userspace 4.1.x rejects the AUDIT_SET control ops (-b/-f/-r/-e)
  #      that the module prepends to its generated rules file, so `auditctl -R`
  #      aborts on line 2 ("error in line 2") and loads nothing. Audit is
  #      already enabled and the backlog limit applied via boot.kernelParams,
  #      so we load only the rule directives.
  #   2. The upstream service runs before sysinit.target, but several watch
  #      rules reference paths created at runtime (e.g. /var/cron/tabs). On a
  #      missing path `auditctl -w` fails and aborts the load, so we run late —
  #      after those paths exist, blocking multi-user.target until done (the VM
  #      test waits on default.target before asserting the rules are present).
  systemd.services.audit-rules-nixos = {
    wantedBy = lib.mkForce [ "multi-user.target" ];
    before = lib.mkForce [ "multi-user.target" ];
    after = [
      "cron.service"
      "systemd-tmpfiles-setup.service"
    ];
    unitConfig.DefaultDependencies = lib.mkForce true;
    serviceConfig = {
      ExecStart = lib.mkForce "${auditctl} -R ${auditRulesFile}";
      ExecStopPost = lib.mkForce [ "${auditctl} -D" ];
    };
  };
}
