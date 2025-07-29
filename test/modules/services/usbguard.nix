{ lib, ... }:
{
  services.usbguard.rules = lib.strings.concatLines [
    ''
      allow with-interface equals { 08:*:* }
    ''
  ];
}
