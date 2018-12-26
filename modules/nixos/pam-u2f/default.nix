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
            if parentConfig.blox.features.betterU2f.enable then
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
in
  {
    options = {
      blox.features.betterU2f.enable = mkOption {
        description = "U2F PAM module to be used as a second factor and passing arguments to pam_u2f.so";
        default = false;
        type = types.bool;
        example = ''
          {
            hardware.u2f.enable = true;
            security.pam.enableU2F = true;
            security.pam.use2Factor = true;
            security.pam.u2fModuleArgs = "cue";
            security.pam.services."sudo".use2Factor = false;
          }
        '';
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
  }
