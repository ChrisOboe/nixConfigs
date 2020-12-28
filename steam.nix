{ config, lib, pkgs, ... }:
{
  config = {
    hardware = {
      opengl = {
          driSupport32Bit = true;
          extraPackages32 = [ pkgs.pkgsi686Linux.libva ] ;
      };
      pulseaudio.support32Bit = true;
    };

    environment.systemPackages = with pkgs; [
        steam
    ];
  };
}


