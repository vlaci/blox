{ config, pkgs, lib, ... }: with lib;

let
  parentConfig = config;
  overrideServices = { name, config, ...}: {
    options = {
        use2Factor = mkOption {
          description = "If set to true u2f is used as 2nd factor.";
          default = parentConfig.security.pam.use2Factor;
        };
        u2fModuleArgs = mkOption {
          description = "Additional arguments to pass to pam_u2f.so";
          default = parentConfig.security.pam.u2fModuleArgs;
        };
        text = mkOption {
          apply = svc:
            if parentConfig.blox.profiles.yubikey.pamU2f.enable then
              builtins.readFile (
                pkgs.runCommand "pam-${name}-u2f"
                  { inherit svc; passAsFile = [ "svc" ]; } ''
                  ${./post-process-pam-service.sh} \
                    $svcPath \
                    $out \
                    ${escapeShellArgs [ config.use2Factor config.u2fModuleArgs ]}
                ''
              )
            else
              svc
            ;
        };
    };
  };
  cfg = config.blox.profiles.yubikey;
in
  {
    options = {
      blox.profiles.yubikey = {
        enable = mkEnableOption "Yubikey Challenge-Response Mode";
        pamU2f.enable = mkOption {
          description = "U2F PAM module to be used as a second factor and passing arguments to pam_u2f.so";
          default = false;
          type = types.bool;
          example = ''
            {
              security.pam.enableU2F = true;
              security.pam.use2Factor = true;
              security.pam.u2fModuleArgs = "cue";
              security.pam.services."sudo".use2Factor = false;
            }
          '';
        };
      };
      security.pam.services = mkOption {
        type = with types; loaOf (submodule overrideServices);
      };
      security.pam.u2fModuleArgs = mkOption {
        description = ''
          Additional arguments to pass to pam_u2f.so in all pam services.
          A service definition may override this setting.
        '';
        example = ''"cue"'';
        default = "";
      };
      security.pam.use2Factor = mkOption {
        description = ''
          If set to true u2f is used as 2nd factor in all pam services.
          A service definition may override this setting.
        '';
        default = false;
      };
    };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      yubikey-personalization
      yubioath-desktop
    ] ++ optionals config.blox.profiles.workstation.enable [
      yubikey-personalization-gui
    ];

    hardware.u2f.enable = true;

    services.pcscd.enable = true;
    services.udev.packages = with pkgs; [
      yubikey-personalization
    ];
  };
}
