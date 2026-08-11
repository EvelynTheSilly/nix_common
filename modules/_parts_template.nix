{inputs, ...}: {
  imports = [inputs.flake-parts.flakeModules.nixpkgs];
  perSystem = {pkgs, ...}: {
    packages.NAME = inputs.wrapper-modules.wrappers.NAME.wrap {
      inherit pkgs;
      package = pkgs.NAME;
    };
  };
}
