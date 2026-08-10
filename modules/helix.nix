{
  self,
  inputs,
  ...
}: {
  flake.packages.x86_64-linux.helix = let
    pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
  in
    inputs.wrapper-modules.wrappers.helix.wrap {
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
}
