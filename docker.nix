{ config, lib, pkgs, ... }:
{
  config = {
    virtualisation.podman = {
      enable = true;
      dockerCompat = true;
    }
}
