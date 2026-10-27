{
  inputs,
  self,
  withSystem,
  ...
}: {
  imports = [inputs.flake-parts.flakeModules.nixpkgs inputs.home-manager.flakeModules.home-manager];
  flake.homeConfigurations.asahi_mac = withSystem "aarch64-linux" ({
    pkgs,
    self',
    ...
  }:
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = import pkgs.path {
        inherit (pkgs.stdenv.hostPlatform) system;
        config = pkgs.config // {allowUnfree = true;};
      };
      extraSpecialArgs = {inherit self';};
      modules = [
        {
          home.username = "evelyn";
          home.homeDirectory = "/home/evelyn";
          home.stateVersion = "26.05";
        }
        self.homeModules.packages
      ];
    });
}
