{inputs, ...}: {
  imports = [inputs.flake-parts.flakeModules.nixpkgs];
  perSystem = {
    pkgs,
    self',
    ...
  }: {
    packages.niri = inputs.wrapper-modules.wrappers.niri.wrap {
      inherit pkgs;
      package = pkgs.niri;
      settings = {
        binds =
          {
            # apps
            "Mod+T".spawn-sh = "${pkgs.lib.getExe self'.packages.alacritty}";
            "Mod+B".spawn-sh = "${pkgs.lib.getExe pkgs.firefox}";
            "Mod+D".spawn-sh = "${pkgs.lib.getExe pkgs.wofi}";

            "Mod+S".screenshot = _: {};
            "Mod+Ctrl+S".screenshot-screen = _: {};
            "Mod+Shift+S".screenshot-window = _: {};

            "Mod+Q" = _: {
              props.repeat = false;
              content.close-window = _: {};
            };
            "Mod+W".toggle-column-tabbed-display = _: {};
            "Mod+F".toggle-window-floating = _: {};
            "Mod+Ctrl+F".maximize-column = _: {};
            "Mod+Shift+F".fullscreen-window = _: {};

            # nav
            "Mod+H".focus-column-left = _: {};
            "Mod+J".focus-window-down = _: {};
            "Mod+K".focus-window-up = _: {};
            "Mod+L".focus-column-right = _: {};

            "Mod+Shift+H".consume-or-expel-window-left = _: {};
            "Mod+Shift+J".move-window-down = _: {};
            "Mod+Shift+K".move-window-up = _: {};
            "Mod+Shift+L".consume-or-expel-window-right = _: {};

            "Mod+Left".move-workspace-to-monitor-left = _: {};
            "Mod+Right".move-workspace-to-monitor-right = _: {};

            # misc
            "Mod+O".toggle-overview = _: {};
          }
          // builtins.listToAttrs (
            map (n: {
              name = "Mod+${toString n}";
              value = {
                move-window-to-workspace = n;
              };
            }) (pkgs.lib.range 1 9)
          );
        input = {
          keyboard.xkb = {
            layout = "us,ru";
            options = "grp:win_space_toggle,compose:ralt,ctrl:nocaps";
          };
          warp-mouse-to-focus = _: {};
          focus-follows-mouse = _: {};
        };
        layout = {
          gaps = 16;
          center-focused-column = "never";
        };
        focus-ring.off = _: {};
        border = {
          width = 2;
          active-color = "ffc87f";
          inactive-color = "505050";
          urgent-color = "9b0000";
        };
        spawn-at-startup = [
          "noctalia -d"
          "${pkgs.lib.getExe self'.packages.alacritty}"
          ""
        ];
        prefer-no-csd = _: {};
        # screenshow-path = null;
      };
    };
  };
}
