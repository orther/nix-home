{ config, pkgs, lib, ... }:
let
  sources = import ../nix/sources.nix;
  pkgs = import sources.nixpkgs { };
in {
  imports = [
    ../program/editor/doom-emacs/default.nix
    ../program/editor/neovim/default.nix
    ../program/terminal/tmux/default.nix
    ../program/terminal/npm-bins/index.nix

    ../program/file-manager/ranger/index.nix
    ../program/networking/nmap/index.nix
    ../program/networking/ssh/index.nix

    ../script/index.nix
  ];

  elemental.home.program.editor.doom-emacs.enable = true;
  elemental.home.program.editor.neovim.enable = true;
  elemental.home.program.networking.ssh.enable = true;

  home.packages = with pkgs;
    [
      alacritty
      fish
      fish-foreign-env

      # Rust CLI Tools! I love rust.
      bandwhich
      bat
      broot
      coreutils
      exa
      fd
      hexyl
      hyperfine
      #navi
      nushell
      ripgrep
      starship
      tokei
      topgrade
      xsv

      # Utils
      age
      nmap
      ssh-audit
      ytop
      pueue
      zoxide

      # Common CLI tools
      fzf
      gnupg
      gnutar
      gopass
      termtosvg
      m-cli

      # Development
      ctags
      direnv
      dnsutils
      elixir
      exercism
      git-crypt
      gitAndTools.gitflow
      glow
      gnumake
      go
      jq
      lorri
      lua
      luarocks
      niv
      nixpkgs-fmt
      nodejs
      pre-commit
      rustup
      terraform_0_12
      tmux
      yarn
      yq
      ## Python Dev
      python37Packages.jupyterlab
      python37Packages.pylint

      # Files and networking
      #brig
      #ipfs
      croc
      gcsfuse
      gocryptfs
      magic-wormhole
      qrencode
      ranger
      restic
      syncthing
      whois
      wrk
      zstd

      # Media
      youtube-dl
      imagemagick

      # Overview
      htop
      #wtf
      lazygit
      neofetch

      # Jokes
      cowsay
      fortune
      figlet
      lolcat
      nms
    ] ++ lib.optionals stdenv.isLinux [
      # Graphical
      anki
      joplin-desktop
      standardnotes

      # Devlopment Graphical
      android-studio
      vscode

      # Files and Networking
      sshfs
    ];

  # Git
  programs.git = {
    enable = true;
    userName = "Brandon Orther";
    userEmail = "brandon@orther.dev";
    signing.key = "0xC717DCA60748D52A";
    signing.signByDefault = true;
    extraConfig = {
      url = { "git@github.com:" = { insteadOf = "https://github.com/"; }; };
    };
    # Aliases
    aliases = {
      "s" = "status";
      "co" = "checkout";
      "br" = "branch";
      # Commits, additions, and modifications
      "cm" = "commit -m";
      "aa" = "add .";
      "rh" = "reset --hard";
      # Logging
      "lgo" = "log --oneline --graph";
      "lo" = "log --oneline";
      "ln" = "log -n"; # follow with a number to show n logs
      "lon" = "log --oneline -n"; # follow with a number to show n logs
    };
  };

  # Environment
  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "firefox";
    TERMINAL = "alacritty";
  };
}
