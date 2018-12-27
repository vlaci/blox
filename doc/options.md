# Name

blox - Supported configuration options

# Description

This module defines a couple of customization options and extend some built-in ones too.

# Options

The following section lists all custom options available in this configuration.

## Options valid in both nixos and home-manager configurations:

### blox.features.development.enable

Whether to enable placeholder to enable all development features in home-manager environment.

*Type:* `boolean`


*Default:* `false`

*Declared by:*

> **[`<modules/nixos/development.nix>`](../modules/nixos/development.nix)**  
> **[`<modules/home/development/default.nix>`](../modules/home/development/default.nix)**  

*Valid in:* nixos, home-manager

### blox.features.workstation.enable

Whether to enable .

*Type:* `boolean`


*Default:* `false`

*Declared by:*

> **[`<modules/nixos/workstation/default.nix>`](../modules/nixos/workstation/default.nix)**  
> **[`<modules/home/workstation/default.nix>`](../modules/home/workstation/default.nix)**  

*Valid in:* nixos, home-manager

### blox.features.zsh.enable

Whether to enable ZSH with sane (grml) defaults.

*Type:* `boolean`


*Default:* `false`

*Declared by:*

> **[`<modules/nixos/shell.nix>`](../modules/nixos/shell.nix)**  
> **[`<modules/home/shell/default.nix>`](../modules/home/shell/default.nix)**  

*Valid in:* nixos, home-manager

## Options valid in only nixos configurations:

### blox.features.betterU2f.enable

U2F PAM module to be used as a second factor and passing arguments to pam_u2f.so

*Type:* `boolean`


*Default:* `false`

*Example:*

```nix
{
  hardware.u2f.enable = true;
  security.pam.enableU2F = true;
  security.pam.use2Factor = true;
  security.pam.u2fModuleArgs = "cue";
  security.pam.services."sudo".use2Factor = false;
}
```

*Declared by:*

> **[`<modules/nixos/pam-u2f/default.nix>`](../modules/nixos/pam-u2f/default.nix)**  

*Valid in:* nixos

### blox.features.docker.enable

Whether to enable docker.

*Type:* `boolean`


*Default:* `false`

*Declared by:*

> **[`<modules/nixos/virtualisation/docker.nix>`](../modules/nixos/virtualisation/docker.nix)**  

*Valid in:* nixos

### blox.features.libvirt.enable

Whether to enable libvirt.

*Type:* `boolean`


*Default:* `false`

*Declared by:*

> **[`<modules/nixos/virtualisation/libvirt.nix>`](../modules/nixos/virtualisation/libvirt.nix)**  

*Valid in:* nixos

### blox.features.networkmanager.enable

Whether to enable Networkmanager with sane defaults.

*Type:* `boolean`


*Default:* `false`

*Declared by:*

> **[`<modules/nixos/networkmanager.nix>`](../modules/nixos/networkmanager.nix)**  

*Valid in:* nixos

### blox.features.sshd.enable

Whether to enable Use sshd with default configuration.

*Type:* `boolean`


*Default:* `false`

*Declared by:*

> **[`<modules/nixos/sshd.nix>`](../modules/nixos/sshd.nix)**  

*Valid in:* nixos

### blox.features.tmux.enable

Whether to enable tmux with sane default configuration.

*Type:* `boolean`


*Default:* `false`

*Declared by:*

> **[`<modules/nixos/shell.nix>`](../modules/nixos/shell.nix)**  

*Valid in:* nixos

### blox.home-manager.config

Global Home Manager configuration.
It can be specified the same way as in `home-manager.users.<name>`
and it applies to all regular users (`isNormalUser` attribute is set).

There are some optional argument available to the global home manager
modules, namely:

- *user*: The current user who the configuration is generated for\
- *nixosConfig*: The global nixos configuration\

Note that all `features` set in the global configuration is inherited
by home manager and can be explicitly disabled.


*Type:* `attribute set or function`


*Default:* `{}`

*Example:*

```nix
{
  blox.home-manager.config =
    { pkgs, ... }:
    {
      blox.features.keepass.enable = true;

      home.packages = with pkgs; [
        rustup
      ];
    };
}
```

*Declared by:*

> **[`<modules/nixos/home-manager.nix>`](../modules/nixos/home-manager.nix)**  

*Valid in:* nixos

### blox.i18n.lang

Quickly set locale settings

*Type:* `one of "hu", "us"`


*Default:* `"us"`

*Example:* `"hu"`

*Declared by:*

> **[`<modules/nixos/i18n.nix>`](../modules/nixos/i18n.nix)**  

*Valid in:* nixos

### blox.i18n.xlayout

enabled xlayout

*Type:* `strings concatenated with ","`


*Default:* `"blox.i18n.lang"`

*Example:* `"hu,us"`

*Declared by:*

> **[`<modules/nixos/i18n.nix>`](../modules/nixos/i18n.nix)**  

*Valid in:* nixos

### blox.users.users

Users with sane defaults

*Type:* `list or attribute set of attribute sets`


*Default:* `[]`

*Declared by:*

> **[`<modules/nixos/users.nix>`](../modules/nixos/users.nix)**  

*Valid in:* nixos

### security.pam.services.<name?>.u2fModuleArgs

Additional arguments to pass to pam_u2f.so

*Type:* `unspecified`


*Default:* `""`

*Declared by:*

> **[`<modules/nixos/pam-u2f/default.nix>`](../modules/nixos/pam-u2f/default.nix)**  

*Valid in:* nixos

### security.pam.services.<name?>.use2Factor

If set to true u2f is used as 2nd factor.

*Type:* `unspecified`


*Default:* `false`

*Declared by:*

> **[`<modules/nixos/pam-u2f/default.nix>`](../modules/nixos/pam-u2f/default.nix)**  

*Valid in:* nixos

### security.pam.u2fModuleArgs

Additional arguments to pass to pam_u2f.so in all pam services.
A service definition may override this setting.


*Type:* `unspecified`


*Default:* `""`

*Example:* `"cue"`

*Declared by:*

> **[`<modules/nixos/pam-u2f/default.nix>`](../modules/nixos/pam-u2f/default.nix)**  

*Valid in:* nixos

### security.pam.use2Factor

If set to true u2f is used as 2nd factor in all pam services.
A service definition may override this setting.


*Type:* `unspecified`


*Default:* `false`

*Declared by:*

> **[`<modules/nixos/pam-u2f/default.nix>`](../modules/nixos/pam-u2f/default.nix)**  

*Valid in:* nixos

### services.xserver.displayManager.lightdm.greeters.gtk.cursor

Cursor theme to use

*Type:* `null or submodule`


*Default:* `null`

*Example:*

```nix
{
  name = "Numix-Cursor";
  package = pkgs.numix-cursor-theme;
}
```

*Declared by:*

> **[`<modules/nixos/workstation/cursor.nix>`](../modules/nixos/workstation/cursor.nix)**  

*Valid in:* nixos

### services.xserver.displayManager.lightdm.greeters.gtk.cursor.name

Cursor theme name

*Type:* `Concatenated string`

<object object at 0x7ffff7fab140>

*Declared by:*

> **[`<modules/nixos/workstation/cursor.nix>`](../modules/nixos/workstation/cursor.nix)**  

*Valid in:* nixos

### services.xserver.displayManager.lightdm.greeters.gtk.cursor.package

Cursor theme package

*Type:* `package`

<object object at 0x7ffff7fab150>

*Declared by:*

> **[`<modules/nixos/workstation/cursor.nix>`](../modules/nixos/workstation/cursor.nix)**  

*Valid in:* nixos

### users.users.<name?>.home-config

Extra home manager configuration to be defined inline

*Type:* `attribute set`


*Default:* `{}`

*Declared by:*

> **[`<modules/nixos/users.nix>`](../modules/nixos/users.nix)**  

*Valid in:* nixos

### users.users.<name?>.isAdmin

Whether to enable sudo access.

*Type:* `boolean`


*Default:* `false`

*Declared by:*

> **[`<modules/nixos/users.nix>`](../modules/nixos/users.nix)**  

*Valid in:* nixos

## Options valid in only home-manager configurations:

### blox.features.development

Development tools related options.


*Type:* `submodule`


*Default:* `{}`

*Example:*

```nix
# enable all subgroups:
{ enable = true; }

# enable specific groups:
{
  c.enable = true;
  python.enable = true;
}

# enable everything but Python:
{
  enable = true;
  python.enable = false;
}
```

*Declared by:*

> **[`<modules/home/development/default.nix>`](../modules/home/development/default.nix)**  

*Valid in:* home-manager

### blox.features.development.c.enable

Whether to enable C/C++ tooling.

*Type:* `boolean`


*Default:* `"blox.features.development.enable"`

*Declared by:*

> **[`<modules/home/development/default.nix>`](../modules/home/development/default.nix)**  

*Valid in:* home-manager

### blox.features.development.python.enable

Whether to enable Python (2 and 3) tooling.

*Type:* `boolean`


*Default:* `"blox.features.development.enable"`

*Declared by:*

> **[`<modules/home/development/default.nix>`](../modules/home/development/default.nix)**  

*Valid in:* home-manager

### blox.features.development.rust.enable

Whether to enable Rust tooling.

*Type:* `boolean`


*Default:* `"blox.features.development.enable"`

*Declared by:*

> **[`<modules/home/development/default.nix>`](../modules/home/development/default.nix)**  

*Valid in:* home-manager

### blox.features.development.tools.enable

Whether to enable miscellaneous tools.

*Type:* `boolean`


*Default:* `"blox.features.development.enable"`

*Declared by:*

> **[`<modules/home/development/default.nix>`](../modules/home/development/default.nix)**  

*Valid in:* home-manager

### blox.features.keepass.enable

Whether to enable KeePass with plugins.

*Type:* `boolean`


*Default:* `false`

*Declared by:*

> **[`<modules/home/keepass.nix>`](../modules/home/keepass.nix)**  

*Valid in:* home-manager

### blox.features.workstation.compositor.enable

Whether to enable compositing.

*Type:* `boolean`


*Default:* `"!nixosConfig.system.build.vm"`

*Declared by:*

> **[`<modules/home/workstation/compositor/default.nix>`](../modules/home/workstation/compositor/default.nix)**  

*Valid in:* home-manager

# See Also

[`configuration.nix(5)`](https://nixos.org/nixos/manual/options.html),
[`home-configuration.nix(5)`](https://rycee.gitlab.io/home-manager/options.html)
