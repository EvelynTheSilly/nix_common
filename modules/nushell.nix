{
  self,
  inputs,
  ...
}: {
  imports = [inputs.flake-parts.flakeModules.nixpkgs];
  perSystem = {pkgs, self', ...}: {
    
    packages.nushell =
    let
      carapace_nu = pkgs.runCommand "carapace nu generator" {} ''
        mkdir $out/
        ${pkgs.nushell}/bin/nu -c '${pkgs.lib.getExe pkgs.carapace} _carapace nushell | save --force $"($env.out)/carapace.nu"'
      '';

      starship_nu = pkgs.runCommand "starship nu generator" {} ''
        mkdir $out/
        ${pkgs.nushell}/bin/nu -c '${pkgs.lib.getExe self'.packages.starship} init nu | save -f $"($env.out)/starship.nu"'
      '';
    in
    inputs.wrapper-modules.wrappers.nushell.wrap {
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

        source "${carapace_nu}/carapace.nu"
        source "${starship_nu}/starship.nu"
      '';
    };
  };
}
