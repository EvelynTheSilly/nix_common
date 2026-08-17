{inputs, ...}: {
  imports = [inputs.flake-parts.flakeModules.nixpkgs];
  perSystem = {
    pkgs,
    self',
    ...
  }: {
    packages.NAME = inputs.wrapper-modules.wrappers.NAME.wrap {
      inherit pkgs;
      package = pkgs.NAME;
    };
  };
}
