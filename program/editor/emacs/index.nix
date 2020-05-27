{ config, lib, pkgs, ... }:

{
  xdg.configFile."doom/config.el".source = ./config/config.el;
  xdg.configFile."doom/init.el".source = ./config/init.el;
  xdg.configFile."doom/packages.el".source = ./config/packages.el;
}
