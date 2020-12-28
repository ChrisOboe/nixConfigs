{ config, lib, pkgs, ... }:
{
  config = {
    # Enable the OpenSSH daemon.
    services.openssh = {
      enable = true;
      startWhenNeeded = false;
      passwordAuthentication = true;
      authorizedKeysCommand = "/etc/ssh/getAuthorizedKeys.sh";
      authorizedKeysCommandUser = "sshd";
    };
    systemd.services.sshd.path = [ pkgs.bash pkgs.curl ];
    environment.etc."ssh/getAuthorizedKeys.sh" = {
      text = "#!/bin/sh\nexec ${pkgs.curl}/bin/curl https://ak.oboe.email/authorized_keys";
      mode = "0755";
      user = "root";
    };
  };
}
