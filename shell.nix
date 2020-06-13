let
  sources = import ./nix/sources.nix;
  pkgs = import sources.nixpkgs { };

  # This provides a development environment that can be used with nix-shell
  shell = pkgs.mkShell {
    name = "yarn-dev-shell";

    # These programs will be available inside the nix-shell.
    buildInputs = [
      pkgs.yarn2nix # Generate nix expressions from a yarn.lock file
      pkgs.nix # Purely Functional Package Manager
      pkgs.niv # Dependency management for Nix projects
      pkgs.nodejs # Event-driven I/O framework for the V8 JavaScript engine
      pkgs.pkgconfig # Allows packages to find out information about other packages
      # pkgs.git # Distributed version control system
      # pkgs.yarn # Dependency management for javascript
    ];

    shellHook = ''
      echo "Home Manager - Dev Env Shell" \
      | ${pkgs.figlet}/bin/figlet -f banner -c \
      | ${pkgs.lolcat}/bin/lolcat

      echo "NOTE: you may need to export GITHUB_TOKEN if you hit rate limits with niv"
      echo "Commands:
        * niv update <package> - update package

      "
    '';
  };

  devops = pkgs.stdenv.mkDerivation {
    name = "devops-shell";
    buildInputs = [
      pkgs.niv # Dependency management for Nix projects
    ];
    shellHook = ''
      echo "DevOps Tools" \
      | ${pkgs.figlet}/bin/figlet -f banner -c \
      | ${pkgs.lolcat}/bin/lolcat

      echo "NOTE: you may need to export GITHUB_TOKEN if you hit rate limits with niv"
      echo "Commands:
        * niv update <package> - update package

      "
    '';
  };
in shell // { inherit devops; }
