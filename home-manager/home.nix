{config, pkgs, ...}:{
    imports = [
        ./modules/defoult.nix
    ];

    home.username = "wolf4am";
    home.homeDirectory = "/home/wolf4am";
    home.stateVersion = "25.11";

}
