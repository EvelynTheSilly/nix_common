{inputs, ...}: {
  imports = [inputs.flake-parts.flakeModules.nixpkgs inputs.home-manager.flakeModules.home-manager];
  flake.homeModules.packages = {
    pkgs,
    self',
    ...
  }: {
    home.packages = with pkgs;
      [
        vesktop
        alejandra
      ]
      ++ (with self'.packages; [
        helix
        nushell
        fastfetch
      ]);
  };
}
