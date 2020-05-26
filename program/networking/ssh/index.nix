{ config, lib, pkgs, ... }:

let
  cfg = config.elemental.home.program.networking.ssh;
in
{
  options.elemental.home.program.networking.ssh = {
    enable = lib.mkEnableOption "Enable the SSH networking";
  };

  config = lib.mkIf cfg.enable {
    # home.packages = [ pkgs.ssh ];

    # programs.ssh.enable = true;
    home.file.".ssh/config".source = ./private/ssh_config;
    home.file.".ssh/id_rsa-arson.pub".source = ./id_rsa-arson.pub;
    home.file.".ssh/id_rsa-mbpr.pub".source = ./id_rsa-mbpr.pub;

    home.activation.copySSHKeys = lib.hm.dag.entryAfter ["writeBoundary"] ''
        install -D -m600 ${./private/id_rsa-arson} $HOME/.ssh/id_rsa-arson
        install -D -m600 ${./private/id_rsa-mbpr} $HOME/.ssh/id_rsa-mbpr
    '';

    home.activation.authorizedKeys = lib.hm.dag.entryAfter ["writeBoundary"] ''
        install -D -m600 ${./id_rsa-arson.pub} $HOME/.ssh/authorized_keys
    '';


    # programs.ssh.enable = true;
    # programs.ssh.matchBlocks = {
    #   "*" = {
    #     host = "*";
    #     user = "john";
    #   };
    #   foo = lib.hm.dag.entryBefore ["john.example.com"] {
    #     hostname = "example.com";
    #     identityFile = "/home/john/.ssh/foo_rsa";
    #   };
    # };
  };
}
