{ config, pkgs, lib, ... }:

let selfPkgs = import ./default.nix;
in {
  config = {
    home.packages = [
      # add my custom npm package bins
      selfPkgs.npm-bins
      # NOTE: To add npm package cli bin:
      #   1. In this dir run `yarn add some-package`
      #   2. Run `yarn2nix > yarn.nix switch`
      #   3. Add line in `bin` property of package.json
      #   4. Run `home-manager switch`
    ];
  };

}
