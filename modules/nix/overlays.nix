{ ... }:
{
  nixpkgs.overlays = [
    (final: prev: {
      # https://stigui.com/stigs/Anduril_NixOS_STIG/groups/V-268153
      aide = prev.aide.overrideAttrs (old: {
        configureFlags = (old.configureFlags or [ ]) ++ [ "--sysconfdir=/etc/aide" ];
      });
    })
  ];

}
