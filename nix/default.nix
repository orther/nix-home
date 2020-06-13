# copied from https://github.com/nmattia/niv/issues/95#issuecomment-572103208
{ sources ? import ./sources.nix, system ? builtins.currentSystem }:
let
  srcs = self: super: { inherit sources; };
  overlays = [ srcs ];
  config = { };
in import sources.nixpkgs { inherit overlays config system; }
