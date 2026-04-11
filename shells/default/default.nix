{ pkgs, ... }:
{
  devShells.default = pkgs.mkShell {
    packages = with pkgs; [
      self.formatter.${system}
      nixd
      nixfmt
      statix
      deadnix
    ];
  };
}
