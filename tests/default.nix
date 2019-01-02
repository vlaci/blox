
{ system ? builtins.currentSystem
, config ? {}
, pkgs ? import <nixpkgs> { inherit system config; }}:

with import <nixpkgs/nixos/lib/testing.nix> { inherit system; };
with pkgs.lib;

let
  testCases = {
    empty = {
      machine =
        {
          imports = [ ../modules/nixos ];
        };

      testScript =
        ''
          $machine->waitForUnit("default.target");
          $machine->fail("systemctl is-active network-manager.service");
          $machine->fail("systemctl is-active display-manager.service");
          $machine->fail("systemctl is-active docker.service");
          $machine->fail("systemctl is-active libvirtd.service");
          $machine->fail("systemctl is-active sshd.socket");
          $machine->fail("systemctl is-active sshd.service");

          $machine->succeed("test ! -e /etc/zshrc.local");
          $machine->succeed("test ! -e /etc/tmux.conf");

          my $shell = $machine->succeed("echo -n \$SHELL");
          "$shell" eq "/run/current-system/sw/bin/bash" or die("Shell should have been bash but was '$shell'");
        '';
    };
    featureful = {
      machine =
        {
          imports = [ ../modules/nixos ];
          blox = {
            profiles = {
              networkmanager.enable = true;
              sshd.enable = true;
              docker.enable = true;
              libvirt.enable = true;
              tmux.enable = true;
              zsh.enable = true;
              workstation.enable = true;
            };
          };
        };

      testScript =
        ''
          $machine->waitForUnit("default.target");
          $machine->succeed("systemctl is-active network-manager.service");
          $machine->succeed("systemctl is-active display-manager.service");
          $machine->succeed("systemctl is-active docker.service");
          $machine->succeed("systemctl is-active libvirtd.service");
          $machine->succeed("systemctl is-active sshd.socket");
          $machine->fail("systemctl is-active sshd.service");

          $machine->succeed("test -e /etc/zshrc.local");
          $machine->succeed("test -e /etc/tmux.conf");

          my $shell = $machine->succeed("echo -n \$SHELL");
          "$shell" eq "/run/current-system/sw/bin/zsh" or die("Shell should have been zsh but was '$shell'");
        '';
    };
  };
in mapAttrs (name: attrs: makeTest (attrs // {
  inherit name;
})) testCases
