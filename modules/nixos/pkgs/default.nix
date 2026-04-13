{ pkgs, inputs, ... }:
let
  xinux-settings = inputs.xinux-settings.packages.${pkgs.stdenv.hostPlatform.system}.xinux-settings;
in
{

  environment.systemPackages = with pkgs; [
    e-imzo-manager
    xinux-settings
    # (pkgs.callPackage /home/wolf4am/WorkPlace/xinux/upstream/pkgs/by-name/e-/e-imzo/package.nix { })5
  ];
}
