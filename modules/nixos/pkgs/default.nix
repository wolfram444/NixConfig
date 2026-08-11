{ pkgs, inputs, ... }:
let
  xinux-settings = inputs.xinux-settings.packages.${pkgs.stdenv.hostPlatform.system}.xinux-settings;
  bluer = inputs.bluer.packages.${pkgs.stdenv.hostPlatform.system}.default;
in
{

  environment.systemPackages = with pkgs; [
    e-imzo-manager
    xinux-settings
    bluer
    gitte
    jdk
    remmina
    # garage-webui
    # (pkgs.callPackage /home/wolf4am/WorkPlace/xinux/upstream/pkgs/by-name/e-/e-imzo/package.nix { })5
  ];
}
