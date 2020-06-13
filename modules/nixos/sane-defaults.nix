{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    bind
    cifs-utils
    exfat
    exfat-utils
    git
    neovim
    nix-index
    ntfs3g
    openssl
    xdg-user-dirs
  ];

  programs.bcc.enable = true;
  services.fwupd.enable = true;

  environment.variables = {
    EDITOR = "nvim";
  };

  blox.home-manager.config = {
    programs.jq.enable = true;
  };
}
