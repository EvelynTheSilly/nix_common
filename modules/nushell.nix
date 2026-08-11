{
  self,
  inputs,
  ...
}: {
  imports = [inputs.flake-parts.flakeModules.nixpkgs];
  perSystem = {pkgs, self', ...}: {
    packages.nushell = inputs.wrapper-modules.wrappers.nushell.wrap {
      inherit pkgs;
      package = pkgs.nushell;

      "config.nu".content = ''

        mkdir ($nu.data-dir | path join "vendor/autoload")
        ${pkgs.lib.getExe self'.packages.starship} init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

        $env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense' # optional
        mkdir $"($nu.cache-dir)"
        ${pkgs.lib.getExe pkgs.carapace} _carapace nushell | save --force $"($nu.cache-dir)/carapace.nu"

        alias nvim = nix run github:vnikjr/nvf -- 
        alias f = hyfetch 
        alias cloc = cloc --vcs git

        $env.buffer_editor = "${pkgs.lib.getExe self'.packages.helix}"

        $env.config.show_banner = false

        source $"($nu.cache-dir)/carapace.nu"
      '';
    };
  };
}
