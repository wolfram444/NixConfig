{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    profiles.default = {
      enableUpdateCheck = false;
      enableExtensionUpdateCheck = false;
      extensions = with pkgs.vscode-extensions; [
        rust-lang.rust-analyzer
        jdinhlife.gruvbox
        jnoortheen.nix-ide
        pkief.material-product-icons
        pkief.material-icon-theme
        ms-azuretools.vscode-containers
        mkhl.direnv
        christian-kohler.path-intellisense
        brettm12345.nixfmt-vscode
        eamodio.gitlens
      ];

      userSettings = {
        "files.autoSave" = "off";
        "files.insertFinalNewline" = true;
        "editor.wordWrap" = "on";
        "editor.wordWrapColumn" = 60;
        "editor.smoothScrolling" = true;
        "diffEditor.wordWrap" = "on";
        "liveServer.settings.donotShowInfoMsg" = true;
        "explorer.confirmDelete" = false;
        "terminal.integrated.tabs.enabled" = true;
        "window.menuBarVisibility" = "compact";
        "editor.formatOnSave" = true;
        "editor.minimap.enabled" = false;
        "workbench.colorTheme" = "Gruvbox Dark Medium";
        "workbench.productIconTheme" = "material-product-icons";
        "workbench.iconTheme" = "material-icon-theme";
        # "material-icon-theme.files.color" = "#42a5f5";
        "workbench.statusBar.visible" = false;
        "editor.stickyScroll.enabled" = false;
        "editor.mouseWheelZoom" = true;
        "extensions.autoCheckUpdates" = false;
        "editor.fontFamily" = "Roboto Mono";
        "update.mode" = "none";
        "vsicons.dontShowNewVersionMessage" = true;
        "github.copilot.enable" = {
          "*" = false;
          "markdown" = false;
          "plaintext" = false;
          "scminput" = false;
        };

        "[nix]" = {
          "editor.tabSize" = 2;
          "editor.defaultFormatter" = "brettm12345.nixfmt-vscode";
          "editor.formatOnPaste" = true;
          "editor.formatOnSave" = true;
          "editor.formatOnType" = false;
        };
        "nix" = {
          "enableLanguageServer" = true;
          "serverPath" = "nixd";
          "formatterPath" = "nixfmt";
          "serverSettings" = {
            "nixd" = {
              "formatting" = {
                "command" = [
                  "nixfmt"
                ];
              };
              # "options" = {
              #   "nixos" = {
              #     "expr" = "(builtins.getFlake \"/absolute/path/to/flake\").nixosConfigurations.<name>.options";
              #   };
              #   "home-manager" = {
              #     "expr" = "(builtins.getFlake \"/absolute/path/to/flake\").homeConfigurations.<name>.options";
              #   };
              #   "nix-darwin" = {
              #     "expr" = "(builtins.getFlake \"$\{workspaceFolder}/path/to/flake\").darwinConfigurations.<name>.options";
              #   };
              # };
            };
          };
        };
      };
    };
  };
}







# { pkgs, ... }:
# {
#   programs.vscode = {
#     enable = true;

#     package = pkgs.vscode.overrideAttrs {
#       postFixup = ''
#         wrapProgram $out/bin/code \
#           --prefix PATH : ${
#             pkgs.lib.makeBinPath (
#               with pkgs;
#               [
#                 python3
#               ]
#             )
#           };
#       '';
#     };

#     profiles.default = {
#       enableUpdateCheck = false;
#       enableExtensionUpdateCheck = false;
#       extensions = with pkgs.vscode-extensions; [
#         rust-lang.rust-analyzer
#         jdinhlife.gruvbox
#         jnoortheen.nix-ide
#         pkief.material-product-icons
#         pkief.material-icon-theme
#         ms-azuretools.vscode-containers
#         mkhl.direnv
#         christian-kohler.path-intellisense
#         brettm12345.nixfmt-vscode
#         (pkgs.vscode-utils.buildVscodeMarketplaceExtension {
#           mktplcRef = {
#             name = "nix-injection";
#             publisher = "barsikus007";
#             version = "0.0.1";
#             sha256 = "sha256-z6xIFtdXVerhl8ly6Vjo7CMiGEcaRhcFnN+dbwdi+j8=";
#           };
#         })

#       ];

#       userSettings = {
#         "files.autoSave" = "off";
#         "files.insertFinalNewline" = true;
#         "editor.wordWrap" = "on";
#         "editor.wordWrapColumn" = 60;
#         "editor.smoothScrolling" = true;
#         "diffEditor.wordWrap" = "on";
#         "liveServer.settings.donotShowInfoMsg" = true;
#         "explorer.confirmDelete" = false;
#         "terminal.integrated.tabs.enabled" = true;
#         "window.menuBarVisibility" = "compact";
#         "editor.formatOnSave" = true;
#         "editor.minimap.enabled" = false;
#         "workbench.colorTheme" = "Gruvbox Dark Medium";
#         "workbench.productIconTheme" = "material-product-icons";
#         "workbench.iconTheme" = "material-icon-theme";
#         # "material-icon-theme.files.color" = "#42a5f5";
#         "workbench.statusBar.visible" = false;
#         "editor.stickyScroll.enabled" = false;
#         "editor.mouseWheelZoom" = true;
#         "extensions.autoCheckUpdates" = false;
#         "editor.fontFamily" = "Roboto Mono";
#         "update.mode" = "none";
#         "vsicons.dontShowNewVersionMessage" = true;
#         "github.copilot.enable" = {
#           "*" = false;
#           "markdown" = false;
#           "plaintext" = false;
#           "scminput" = false;
#         };

#         "[nix]" = {
#           "editor.tabSize" = 2;
#           "editor.defaultFormatter" = "brettm12345.nixfmt-vscode";
#           "editor.formatOnPaste" = true;
#           "editor.formatOnSave" = true;
#           "editor.formatOnType" = false;
#         };
#         "nix" = {
#           "enableLanguageServer" = true;
#           "serverPath" = "nixd";
#           "formatterPath" = "nixfmt";
#           "serverSettings" = {
#             "nixd" = {
#               "formatting" = {
#                 "command" = [
#                   "nixfmt"
#                 ];
#               };
#               # "options" = {
#               #   "nixos" = {
#               #     "expr" = "(builtins.getFlake \"/absolute/path/to/flake\").nixosConfigurations.<name>.options";
#               #   };
#               #   "home-manager" = {
#               #     "expr" = "(builtins.getFlake \"/absolute/path/to/flake\").homeConfigurations.<name>.options";
#               #   };
#               #   "nix-darwin" = {
#               #     "expr" = "(builtins.getFlake \"$\{workspaceFolder}/path/to/flake\").darwinConfigurations.<name>.options";
#               #   };
#               # };
#             };
#           };
#         };
#         "python.analysis.extraPaths" = [
#           "/home/wolf4am/WorkPlace/nixpkgs/nixos/lib/test-driver/src"
#         ];
#       };
#     };
#   };
# }




