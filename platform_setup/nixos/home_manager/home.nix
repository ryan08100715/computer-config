{ config, pkgs, lib, catppuccin-bat, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "ryan";
  home.homeDirectory = "/home/ryan";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
 
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };
 
  programs = {
    git = {
      enable = true;
      userName = "Ryan";
      userEmail = "ryan08100715@gmail.com";
    };
  
    fish = {
      enable = true;
    };
  
    starship = {
      enable = true;
    };

    
    bat = {
      enable = true;
      config = {
        theme = "catppuccin-macchiato";
      };
      themes = {
        catppuccin-macchiato = {
          src = catppuccin-bat;
          file = "themes/Catppuccin Macchiato.tmTheme";
        };
      };
    };
  };
  # Fonts 
  # fonts.fontdir.enable = true;
  # fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    kitty
  ];

  home.file = {
    ".config/starship.toml".source = ../config/starship.toml;
    ".config/kitty" = {
      source = ../config/kitty;
      recursive = true;
    }; 
    ".config/fcitx5" = {
      source = ../config/fcitx5;
      recursive = true;
    };
    ".local/share/kwin/scripts/move-windows-to-desktops" = {
      source = ../config/kde/move-windows-to-desktops;
      recursive = true;
    };
  };

  #dconf = {
  #  enable = true;
  #  settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
  #  settings."org/gnome/desktop/wm/preferences".button-layout = ":minimize,maximize,close";
 
# 
#  #  # System settings
  #  settings."org/gnome/shell/app-switcher".current-workspace-only = true;
  #  settings."org/gnome/desktop/session".idle-delay = lib.gvariant.mkUint32 0;
  #  settings."org/gnome/desktop/input-sources".xkb-options = [
  #    "terminate:ctrl_alt_bksp"
  #    "ctrl:nocaps"
  #  ];
  #  settings."org/gnome/mutter".experimental-features = ["scale-monitor-framebuffer"];
 
#  #  # Workspaces
  #  settings."org/gnome/mutter".dynamic-workspaces = false;
  #  settings."org/gnome/desktop/wm/preferences".num-workspaces = 10;
  #  
  #  settings."org/gnome/shell/extensions/dash-to-dock".hot-keys = false;
  #  settings."org/gnome/shell/keybindings".switch-to-application-1 = [];
  #  settings."org/gnome/shell/keybindings".switch-to-application-2 = [];
  #  settings."org/gnome/shell/keybindings".switch-to-application-3 = [];
  #  settings."org/gnome/shell/keybindings".switch-to-application-4 = [];
  #  settings."org/gnome/shell/keybindings".switch-to-application-5 = [];
  #  settings."org/gnome/shell/keybindings".switch-to-application-6 = [];
  #  settings."org/gnome/shell/keybindings".switch-to-application-7 = [];
  #  settings."org/gnome/shell/keybindings".switch-to-application-8 = [];
  #  settings."org/gnome/shell/keybindings".switch-to-application-9 = [];
  #  
  #  settings."org/gnome/desktop/wm/keybindings".switch-to-workspace-1 = ["<Super>1"];
  #  settings."org/gnome/desktop/wm/keybindings".switch-to-workspace-2 = ["<Super>2"];
  #  settings."org/gnome/desktop/wm/keybindings".switch-to-workspace-3 = ["<Super>3"];
  #  settings."org/gnome/desktop/wm/keybindings".switch-to-workspace-4 = ["<Super>4"];
  #  settings."org/gnome/desktop/wm/keybindings".switch-to-workspace-5 = ["<Super>5"];
  #  settings."org/gnome/desktop/wm/keybindings".switch-to-workspace-6 = ["<Super>6"];
  #  settings."org/gnome/desktop/wm/keybindings".switch-to-workspace-7 = ["<Super>7"];
  #  settings."org/gnome/desktop/wm/keybindings".switch-to-workspace-8 = ["<Super>8"];
  #  settings."org/gnome/desktop/wm/keybindings".switch-to-workspace-9 = ["<Super>9"];
  #  settings."org/gnome/desktop/wm/keybindings".switch-to-workspace-10 = ["<Super>0"];
 
#  #  settings."org/gnome/desktop/wm/keybindings".move-to-workspace-1 = ["<Super><Shift>1"];
  #  settings."org/gnome/desktop/wm/keybindings".move-to-workspace-2 = ["<Super><Shift>2"];
  #  settings."org/gnome/desktop/wm/keybindings".move-to-workspace-3 = ["<Super><Shift>3"];
  #  settings."org/gnome/desktop/wm/keybindings".move-to-workspace-4 = ["<Super><Shift>4"];
  #  settings."org/gnome/desktop/wm/keybindings".move-to-workspace-5 = ["<Super><Shift>5"];
  #  settings."org/gnome/desktop/wm/keybindings".move-to-workspace-6 = ["<Super><Shift>6"];
  #  settings."org/gnome/desktop/wm/keybindings".move-to-workspace-7 = ["<Super><Shift>7"];
  #  settings."org/gnome/desktop/wm/keybindings".move-to-workspace-8 = ["<Super><Shift>8"];
  #  settings."org/gnome/desktop/wm/keybindings".move-to-workspace-9 = ["<Super><Shift>9"];
  #  settings."org/gnome/desktop/wm/keybindings".move-to-workspace-10 = ["<Super><Shift>0"];
  #    
  #  # Keyboard shortcuts
  #  settings."org/gnome/desktop/wm/keybindings".close = [
  #    "<Alt>F4"
  #    "<Control>q"
  #  ];

  #  settings."org/gnome/desktop/wm/keybindings".switch-applications = [];
  #  settings."org/gnome/desktop/wm/keybindings".switch-applications-backward = [];
  #  settings."org/gnome/desktop/wm/keybindings".switch-windows = ["<Alt>Tab"];
  #  settings."org/gnome/desktop/wm/keybindings".switch-windows-backward = ["<Shift><Alt>Tab"];

  #  settings."org/gnome/settings-daemon/plugins/media-keys".custom-keybindings = [
  #    "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
  #    "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
  #    "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
  #  ];

  #  settings."org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0".name = "Open browser";
  #  settings."org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0".command = "google-chrome-stable";
  #  settings."org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0".binding = "<Super>b";

  #  settings."org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1".name = "Open terminal";
  #  settings."org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1".command = "kitty";
  #  settings."org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1".binding = "<Super>Return";

  #  settings."org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2".name = "Open nautilus";
  #  settings."org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2".command = "nautilus";
  #  settings."org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2".binding = "<Super>e";

  #  # Wallpaper
  #  settings."org/gnome/desktop/background" = {
  #    "picture-uri" = "file:///home/ryan/.local/share/wallpapers/main.png";
  #    "picture-uri-dark" = "file:///home/ryan/.local/share/wallpapers/main.png";
  #  };

  #  # Extensions
  #  settings."org/gnome/shell".disable-user-extensions = false;
  #  settings."org/gnome/shell".enabled-extensions = [
  #    pkgs.gnomeExtensions.unlock-dialog-background.extensionUuid
  #    pkgs.gnomeExtensions.unblank.extensionUuid
  #  ];

  #  settings."org/gnome/shell/extensions/unlock-dialog-background" = {
  #    "picture-uri" = "file:///home/ryan/.local/share/wallpapers/lock.png";
  #    "picture-uri-dark" = "file:///home/ryan/.local/share/wallpapers/lock.png";
  #    "radius" = 5;
  #  };
  #};
}
