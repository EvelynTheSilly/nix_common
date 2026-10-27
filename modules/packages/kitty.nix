{inputs, ...}: {
  imports = [inputs.flake-parts.flakeModules.nixpkgs];
  perSystem = {
    pkgs,
    self',
    ...
  }: {
    packages.kitty = inputs.wrapper-modules.wrappers.kitty.wrap {
      inherit pkgs;
      package = pkgs.kitty;
      settings = {
        background_opacity = 0.2;
        cursor_shape = "beam";
        cursor_trail = 1;
        shell = "${pkgs.lib.getExe self'.packages.nushell}";
        editor = "${pkgs.lib.getExe self'.packages.helix}";
        notify_on_cmd_finish = "unfocused";
      };
    };
  };
}
