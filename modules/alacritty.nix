{inputs, ...}: {
  imports = [inputs.flake-parts.flakeModules.nixpkgs];
  perSystem = {
    pkgs,
    self',
    ...
  }: {
    packages.alacritty = inputs.wrapper-modules.wrappers.alacritty.wrap {
      inherit pkgs;
      package = pkgs.alacritty;
      settings = {
        general.import = ["${inputs.catppuccin.packages.${pkgs.system}.alacritty}/catppuccin-mocha.toml"];
        terminal.shell = {
          program = "${pkgs.lib.getExe self'.packages.nushell}";
          args = ["-e" "${pkgs.lib.getExe self'.packages.hyfetch}"];
        };
        env.SHELL = "${pkgs.lib.getExe self'.packages.nushell}";
        env.EDITOR = "${pkgs.lib.getExe self'.packages.helix}";
      };
    };
  };
}
