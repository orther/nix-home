{ config, pkgs, lib, ... }:

# To add npm cli bin:
#
# 1. In this dir run `yarn add some-package`
# 2. Add line in `bin` property of package.json
# 3. Run `home-manager switch`

let
  npm-bins = pkgs.mkYarnPackage {
    name = "npm-bins";
    src = ./.;
    packageJSON = ./package.json;
    yarnLock = ./yarn.lock;
    # NOTE: this is optional and generated dynamically if omitted
    # yarnNix = ./yarn.nix;
  };
in {
  config = {
    home.packages = [
      # add my custom npm package bins
      npm-bins
    ];
  };
}
