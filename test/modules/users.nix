{ ... }:
{

  users.users.root = {
    enable = false;
    hashedPassword = null;
    hashedPasswordFile = null;
  };
  users.groups.neal = { };
  users.users.neal = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    password = "password";
    openssh.authorizedKeys = {
      keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDPty6l+Gtw52pLF6dzVIqKTki8LBaTR4Nu7mGAu3TjtBTDmY1tWTpy6UebaQMiYXsTJ6COtaf9ASp/MvSvHXLQhR//oUI10M648AutAGaSiHU/vzo6p6++NYpixhhHQsA6WI29fC0hJzT2ckS2Ef+b+H16HbvtdTyQeYZZZx2Brtzxa1FGkBdQrYwHdj8K6XQW1y0HZEwI1KnWP72lurFm+uwLUqgMetXhFKa288ZRDMf95WHrz+OvHWlbaiYulOtdozNBceF9FjE38sEMg5qvfvbSunHPPKuVZRw1SEL01Jl0abjVbEVXU1pYkCy/AKjO9oaMi/usBPKOsgZNFueH CAC Email Signature Certificate"
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCkQX3PCht0BVHS0w7N1xQWkPAlCvzB2UgePTVETG9PNhrxpsNg0JNdiA64VV9/+wcij4yatDuEav0n+kW7XW8qUrbdMUbGFQpHj9qieFeRuH0eVMsoLKeL78L/0v9zDiGIYNVZt2MoCd38DfrkGDGNoB0oGkdOnEwG28HBYRJSd+ULb2peYMACCTRVh0fV/QpKb+II6C4HeAWutgnxb3FrhWdJBxF6yLeQRinRa4UkkLtxay/ZnTTc7odfRHuhZFMnLKgd8ckIE/DFo1xRi/n8q+Zp4GSatRcwavP11pvkYerTQ1wxYBlaiLjoQs1AVhVe24+9QY1fmpnSKgm9PGDt CAC Email Encryption Certificate"
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC4Tdu2hmshH3ZjyDDRXNo7DsDF0SIMmjDiR63DKYFz6ivAg2w6CUJ+Hv8DZZ3jNfKgQfxAdtfeuVWEtXuvLa+hIvnCdquWhhIcsPH74/BgfpxqTIrdZ8A+kdlX/SGNka3eo6Q8yAqH/9dfapiyOyNd7KWOZA66Ar/dY0aSZ98HIftY8ueIZXiYmArebtmdj2pSDkJvkLxgddaP5APDG7pnEjQ1vgWT8m/vSmzHLk2eV64OCYcQBOna53SWUceCHx8zspCWPnaGjEe6Dfku0jA0O6H+8uXNi+7xI5ErLawyE4gjo0/ccXm8XBqskfCFcPHaVp6Y7bEmEGSdJsrmq61v CAC Cert 4"
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD55Rd2hBDhjvTQd+AGCNChm1OGtztxAPuNQsZrt/J1HFGfJ5TwNgbybwgeLQEmVNQkgy4p+GMT/zR8L+DlBveeUtOqd105IGMqKwfJY8/oJ8P2ZeTI6DwXt4Dn6Suwm/C6do8OPguPPrHQwqQGHhg8Ct0LFrt+MlWWfZYdMWj/l4Fm9dm7T5ax8QLV38jSAjpHRBSU72dVUTGsmcarWx3ajWq6w5Cw+DHe0YawQkGzRD0nI6kaEf2sCwu0uxJU1yPI1/VNxTuroepcNleevTKCbHDQigTWMFiX9P6ImZu1+uIwPOOzlAcpbFCMnYIH/6F1BJzhIJvEVULSPPsy3FKP CAC Cert 5"
      ];
    };
  };
}
