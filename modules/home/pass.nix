{ config, lib, pkgs, ... }: with lib;

let
  cfg = config.blox.profiles.pass;
in {
  options.blox.profiles.pass.enable = mkEnableOption "Pass with plugins";

  config = mkIf cfg.enable {
    programs.browserpass.enable = true;
    home.packages = with pkgs; [
      (bloxpkgs.unstable.pass.withExtensions (x: with x; [ pass-import pass-genphrase pass-otp pass-update ]))
      rofi-pass
    ];
  };
}
