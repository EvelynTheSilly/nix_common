{inputs, ...}: {
  imports = [inputs.flake-parts.flakeModules.nixpkgs inputs.home-manager.flakeModules.home-manager];
  homeModules.EXAMPLE = {
    pkgs,
    self',
    ...
  }: {
    # meowzers
  };
}
