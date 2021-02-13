{ config, lib, pkgs, ... }:
{
  config = {
    # i18n
    i18n.defaultLocale = "de_DE.UTF-8";
    time.timeZone = "Europe/Berlin";

    # Enable sound.
    sound.enable = true;
    hardware.pulseaudio.enable = true;

    # Enable the X11 windowing system.
    services.xserver = {
      enable = true;
      libinput.enable = true;
      windowManager.notion.enable = true;
      displayManager = {
        lightdm.enable = true;
        defaultSession = "none+notion";
      };
      xkbOptions = "caps:hyper";
    };

    # behaviour
    services.logind.extraConfig = ''
      HandlePowerKey = ignore
      IdleAction=hybrid-sleep
      IdleActionSec=60min
    '';
    environment.extraInit = ''
      xset s off -dpms
    '';

    # users
    users.groups."chris".gid = 1000;
    users.users."chris" = {
      uid = 1000;
      isNormalUser = true;
      group = "chris";
      extraGroups = [ "wheel" "docker" ];
    };

    # software
    environment.systemPackages = with pkgs;[
      # desktop
      rxvt-unicode
      ncpamixer

      # gui software
      mpv
      gcolor2
      gparted
      firefox
      kodi
      wireshark-qt
      virt-manager
      openscad
      mupdf
      feh

      # kakoune dev
      kak-lsp
      xclip
      ccls
      nixpkgs-fmt
      go
      gopls
      jq
      gogetdoc
      gotools
      gocode

      # remote
      freerdp
      tigervnc

      # user server
      home-manager
    ];

    # package settings
    environment.variables.MOZ_USE_XINPUT2 = "1";
    nixpkgs.config = {
      allowUnfree = true;

      packageOverrides = super:
        let self = super.pkgs; in
        {
          rxvt-unicode = super.rxvt-unicode.override
            {
              configure = { availablePlugins, ... }: {
                plugins = [ ];
              };
            };
          # kodi = super.kodi.override
          #   {
          #     #dbusSupport = false;
          #     joystickSupport = false;
          #     nfsSupport = false;
          #     sambaSupport = false;
          #     udevSupport = false;
          #     usbSupport = false;
          #     useWayland = false;
          #     pvr-tvh = true;
          #   };
        };
    };
  };
}
