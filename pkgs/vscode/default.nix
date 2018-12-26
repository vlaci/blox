{ vscode, fetchurl }:

vscode.overrideAttrs (super: rec {
  name = "vscode-${version}";
  version = "1.30.0";
  src = fetchurl {
    name = "VSCode_${version}_linux-x64.tar.gz";
    url = "https://vscode-update.azurewebsites.net/${version}/linux-x64/stable";
    sha256 = "1zbnyff0q15xkvkrs14rfgyn6xb9v0xivcnbl8yckl71s45vb2l1";
  };
})
