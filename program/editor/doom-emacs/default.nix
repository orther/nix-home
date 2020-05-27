{ config, lib, pkgs, ... }:

let cfg = config.elemental.home.program.editor.doom-emacs;
in {
  options.elemental.home.program.editor.doom-emacs = {
    enable = lib.mkEnableOption "Enable the doom-emacs editor";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      sbcl
      editorconfig-checker
      gocode
      gomodifytags
      gotests
      # fonts as an Emacs package
      emacs-all-the-icons-fonts
      # ispell
      ispell
      hunspell
      hunspellDicts.en-us
      # markdown
      pandoc
      # nix
      nixfmt
      # sh
      shellcheck
    ];

    xdg.configFile."doom/config.el".source = ./config/config.el;
    xdg.configFile."doom/init.el".source = ./config/init.el;
    xdg.configFile."doom/packages.el".source = ./config/packages.el;
  };
}
