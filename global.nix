{ config, lib, pkgs, ... }:
{
  imports = [ <home-manager/nixos> ];

  config = {
    # setup kernel
    boot.kernelPackages = pkgs.linuxPackages_latest;

    # setup network
    networking = {
      useDHCP = false;
      firewall.enable = false;
      enableIPv6 = true;
    };

    # setup nix
    system.stateVersion = "20.03";
    nixpkgs.config.allowUnfree = true;

    # setup home manager
    home-manager.useUserPackages = true;
    home-manager.useGlobalPkgs = true;

    # setup root
    home-manager.users.root = { pkgs, ... }: {
      programs.bash.enable = true;
      programs.powerline-go = {
        enable = true;
        modules = [
          "host"
          "user"
          "ssh"
          "cwd"
          "jobs"
          "exit"
        ];
        settings = {
          hostname-only-if-ssh = true;
          mode = "flat";
        };
      };
      programs.htop = {
        enable = true;
        cpuCountFromZero = true;
        fields = [ "PID" "USER" "M_RESIDENT" "NICE" "PERCENT_CPU" "TIME" "IO_PRIORITY" "IO_READ_RATE" "IO_WRITE_RATE" "RBYTES" "WBYTES" "COMM" ];
        hideThreads = true;
        hideUserlandThreads = true;
        highlightBaseName = true;
        shadowOtherUsers = false;
        showProgramPath = false;
        showThreadNames = true;
        sortKey = "PID";
        sortDescending = true;
        treeView = true;
        vimMode = true;
      };
    };

    # software
    environment = {
      systemPackages = with pkgs;[
        killall
        htop
        wget
        screen

        atool
        unzip

        kakoune
      ];
    };
    variables.EDITOR = "kak";
  };
}
