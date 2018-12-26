{ config, lib, ... }: with lib;

let
  cfg.hu = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "hu";
    defaultLocale = "hu_HU.UTF-8";
  };
  cfg.us = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };
  supportedLocales = attrNames cfg;
in
{
  options.blox.i18n = {
    lang = mkOption {
      type = types.enum supportedLocales;
      description = "Quickly set locale settings";
      default = "us";
      example = ''"hu"'';
    };
    xlayout = mkOption {
      description = "enabled xlayout";
      type = types.commas;
      default = config.blox.i18n.lang;
      defaultText = "blox.i18n.lang";
      example = ''"hu,us"'';
    };
  };
  config.i18n = mkDefault cfg.${config.blox.i18n.lang};
  config.services.xserver = mkIf config.blox.features.workstation.enable {
    layout = config.blox.i18n.xlayout;
    xkbOptions = mkDefault "grp:lalt_lshift_toggle, compose:rctrl-altgr";
  };
}
