{inputs, ...}: {
  imports = [inputs.flake-parts.flakeModules.nixpkgs];
  perSystem = {pkgs, ...}: {
    packages.helix = inputs.wrapper-modules.wrappers.helix.wrap {
      inherit pkgs;
      package = pkgs.evil-helix;
      settings = {
        theme = pkgs.lib.mkForce "tokyonight";
        editor = {
          line-number = "relative";
          completion-timeout = 5;
          clipboard-provider = "wayland";
          cursor-shape = {
            insert = "bar";
          };
        };
      };
    };
  };
}
