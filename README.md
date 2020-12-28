# nixConfigs
My nix configuration presets

## installation
Here is a minimal example of configuration.nix.

    { config, pkgs, ... }:
    let
      nixConfigs = builtins.fetchGit {
          url = "https://github.com/ChrisOboe/nixConfigs.git";
      };
    in {
      imports = [
        "${nixConfigs}/sshd.nix"
      ];
      
      # set hostname
      networking.hostName = "bodd-vm";
    }

