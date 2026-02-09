{ pkgs, ... }:

{
   programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    profiles.default = {
      enableUpdateCheck = false;
      enableExtensionUpdateCheck = false;
      extensions = with pkgs.vscode-extensions;
        [
          rust-lang.rust-analyzer
          jdinhlife.gruvbox
          jnoortheen.nix-ide
          pkief.material-product-icons
          pkief.material-icon-theme
        ];

        userSettings = {
        "files.autoSave" = "off";
        "files.insertFinalNewline"=true;
        "editor.wordWrap"= "on";
        "editor.wordWrapColumn"= 60;
        "diffEditor.wordWrap"= "on";
        "liveServer.settings.donotShowInfoMsg"= true;
        "explorer.confirmDelete"= false;
        "terminal.integrated.tabs.enabled"=true;
        "window.menuBarVisibility"= "compact";
        "editor.minimap.enabled"= false;
        "workbench.colorTheme"= "Gruvbox Dark Medium";
        "workbench.productIconTheme"= "material-product-icons";
        "workbench.iconTheme" = "material-icon-theme";
        # "material-icon-theme.files.color" = "#42a5f5";
        "workbench.statusBar.visible" = false;
        "editor.stickyScroll.enabled" = false;
        "editor.mouseWheelZoom" = true;
        "extensions.autoCheckUpdates"= false;
        "editor.fontFamily" = "Roboto Mono";
        "update.mode"= "none";
        "vsicons.dontShowNewVersionMessage"= true;
        "github.copilot.enable"= {
          "*"= false;
          "markdown"=false;
          "plaintext"= false;
          "scminput"= false;
        };


    };
  };
};
}
