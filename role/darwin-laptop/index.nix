{ config, lib, pkgs, attrsets, ... }:
{
  imports = [
    # Files to source for fish config
    ../../program/shell/fish/sources.nix
    # Darwin only
    ./script/index.nix
  ];

  programs.alacritty = {
    enable = true;
    settings = lib.attrsets.recursiveUpdate (import ../../program/terminal/alacritty/default-settings.nix) {
      shell.program = "fish";
    };
  };

  # Fish Shell
  programs.fish = lib.attrsets.recursiveUpdate (import ../../program/shell/fish/default.nix) {
    shellInit = ''
      bass source $HOME/.nix-profile/etc/profile.d/nix.sh
      direnv hook fish | source
      set PATH (fd --absolute-path . $HOME/.config/scripts | tr '\n' ':' | sed 's/.$//') $PATH
    '';
  };

  programs.gpg = {
    enable = true;
    settings = {
      default-key = "0x82E36DCCF96E3DE5";
    };
  };

  #services.gpg-agent = {
  #  enable = true;
  #  extraConfig = ''
  #    # Connects gpg-agent to the OSX keychain via the brew-installed
  #    # pinentry program from GPGtools. This is the OSX 'magic sauce',
  #    # allowing the gpg key's passphrase to be stored in the login
  #    # keychain, enabling automatic key signing.
  #    pinentry-program /usr/local/bin/pinentry-mac
  #  '';
  #};
  home.file.".gnupg/gpg-agent.conf".text = ''
    enable-ssh-support
    default-cache-ttl 86400
    max-cache-ttl 86400
    pinentry-program /usr/local/bin/pinentry-mac
  '';

  # Environment
  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "firefox";
    TERMINAL = "alacritty";
  };

  home.file.".hammerspoon".source = ../../de/darwin-only/hammerspoon;
  home.file.".karabiner/karabiner.json".source = ../../de/darwin-only/karabiner/karabiner.json;
}
