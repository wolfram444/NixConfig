{ pkgs, inputs, ... }:

  pkgs.mkShell {
    packages = with pkgs; [
      inputs.self.formatter.${system}
      nixd
      nixfmt
      statix
      deadnix
    ];
}
