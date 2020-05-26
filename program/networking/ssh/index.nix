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
    home.file.".ssh/config".source = ./ssh_config;
    home.file.".ssh/id_rsa".source = ./id_rsa-mbpr;
    home.file.".ssh/id_rsa.pub".source = ./id_rsa-mbpr.pub;

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
