{inputs, ...}: {
  imports = [inputs.flake-parts.flakeModules.nixpkgs];
  perSystem = {
    pkgs,
    self',
    ...
  }: {
    packages.hyfetch = inputs.wrapper-modules.wrappers.hyfetch.wrap {
      inherit pkgs;
      package = pkgs.hyfetch;
      settings = {
        preset = "lesbian";
        mode = "rgb";
        auto_detect_light_dark = true;
        light_dark = "dark";
        lightness = 0.61;
        color_align = {
          mode = "horizontal";
        };
        backend = "fastfetch";
        args = ["--config" "${self'.packages.fastfetch}/fastfetch-settings.json"];
        distro = null;
        pride_month_disable = false;
        custom_ascii_path = null;
      };
    };
  };
}
