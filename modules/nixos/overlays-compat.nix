{ lib, options, ... }: with lib;

{
  nix.nixPath =
    # Prepend default nixPath values.
    options.nix.nixPath.default ++
    # Append our nixpkgs-overlays.
    [ "nixpkgs-overlays=${toString ./overlays-compat}" ]
  ;
}
