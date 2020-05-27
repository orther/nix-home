{ config, lib, pkgs, ... }:

{
  home.configFile."doom/config.el".source = ./config/config.el;
  home.configFile."doom/init.el".source = ./config/init.el;
  home.configFile."doom/packages.el".source = ./config/packages.el;
}
