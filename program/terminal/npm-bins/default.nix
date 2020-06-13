let pkgs = import ../../../nix { };
in {
  npm-bins = pkgs.mkYarnPackage {
    name = "npm-bins";
    src = ./.;
    packageJSON = ./package.json;
    yarnLock = ./yarn.lock;
    # NOTE: this is optional and generated dynamically if omitted
    yarnNix = ./yarn.nix;
  };
}
