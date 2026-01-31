{config, pkgs, ...}:{
    imports = [
        ./modules/defoult.nix
    ];

    home.username = "wolf4am";
    home.homeDirectory = "/home/wolf4am";
    home.stateVersion = "25.11";

    programs.bash = {
        enable = true;
        shellAliases = {
            rebuild = "sudo nixos-rebuild switch --flake ./";
        };
    };


    








}
