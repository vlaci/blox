{ vscode, fetchurl }:
let
  info = builtins.fromJSON (builtins.readFile ./info.json);
in vscode.overrideAttrs (super: rec {
  name = info.name;
  version = info.version;
  src = fetchurl info.fetch;
})
