# Name

blox - Supported configuration options

# Description

This module defines a couple of customization options and extend some built-in ones too.

# Options

The following section lists all custom options available in this configuration.

## Options valid in both nixos and home-manager configurations:

### blox.profiles.development.enable

Whether to enable placeholder to enable all development profiles in home-manager environment.

*Type:* `boolean`


*Default:* `false`

*Declared by:*

> **[`<modules/nixos/development.nix>`](../modules/nixos/development.nix)**  
> **[`<modules/home/development/default.nix>`](../modules/home/development/default.nix)**  

*Valid in:* nixos, home-manager

### blox.profiles.workstation.enable

Whether to enable .

*Type:* `boolean`


*Default:* `false`

*Declared by:*

> **[`<modules/nixos/workstation/default.nix>`](../modules/nixos/workstation/default.nix)**  
> **[`<modules/home/workstation/default.nix>`](../modules/home/workstation/default.nix)**  

*Valid in:* nixos, home-manager

### blox.profiles.zsh.enable

Whether to enable ZSH with sane (grml) defaults.

*Type:* `boolean`


*Default:* `false`

*Declared by:*

> **[`<modules/nixos/shell.nix>`](../modules/nixos/shell.nix)**  
> **[`<modules/home/shell/default.nix>`](../modules/home/shell/default.nix)**  

*Valid in:* nixos, home-manager

## Options valid in only nixos configurations:

### blox.blox.installDocs

Whether to install documentation for `blox`

*Type:* `boolean`


*Default:* `true`

*Declared by:*

> **[`<modules/nixos/blox.nix>`](../modules/nixos/blox.nix)**  

*Valid in:* nixos

### blox.home-manager.config

Global Home Manager configuration.
It can be specified the same way as in `home-manager.users.<name>`
and it applies to all regular users (`isNormalUser` attribute is set).

There are some optional argument available to the global home manager
modules, namely:

- *user*: The current user who the configuration is generated for\
- *nixosConfig*: The global nixos configuration\

Note that all `profiles` set in the global configuration is inherited
by home manager and can be explicitly disabled.


*Type:* `attribute set or function`


*Default:* `{}`

*Example:*

```nix
{
  blox.home-manager.config =
    { pkgs, ... }:
    {
      blox.profiles.keepass.enable = true;

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

### blox.profiles.docker.enable

Whether to enable docker.

*Type:* `boolean`


*Default:* `false`

*Declared by:*

> **[`<modules/nixos/virtualisation/docker.nix>`](../modules/nixos/virtualisation/docker.nix)**  

*Valid in:* nixos

### blox.profiles.libvirt.enable

Whether to enable libvirt.

*Type:* `boolean`


*Default:* `false`

*Declared by:*

> **[`<modules/nixos/virtualisation/libvirt.nix>`](../modules/nixos/virtualisation/libvirt.nix)**  

*Valid in:* nixos

### blox.profiles.networkmanager.enable

Whether to enable Networkmanager with sane defaults.

*Type:* `boolean`


*Default:* `false`

*Declared by:*

> **[`<modules/nixos/networkmanager.nix>`](../modules/nixos/networkmanager.nix)**  

*Valid in:* nixos

### blox.profiles.sshd.enable

Whether to enable Use sshd with default configuration.

*Type:* `boolean`


*Default:* `false`

*Declared by:*

> **[`<modules/nixos/sshd.nix>`](../modules/nixos/sshd.nix)**  

*Valid in:* nixos

### blox.profiles.tmux.enable

Whether to enable tmux with sane default configuration.

*Type:* `boolean`


*Default:* `false`

*Declared by:*

> **[`<modules/nixos/shell.nix>`](../modules/nixos/shell.nix)**  

*Valid in:* nixos

### blox.profiles.yubikey.enable

Whether to enable Yubikey Challenge-Response Mode.

*Type:* `boolean`


*Default:* `false`

*Declared by:*

> **[`<modules/nixos/yubikey/default.nix>`](../modules/nixos/yubikey/default.nix)**  

*Valid in:* nixos

### blox.profiles.yubikey.pamU2f.enable

U2F PAM module to be used as a second factor and passing arguments to pam_u2f.so

*Type:* `boolean`


*Default:* `false`

*Example:*

```nix
{
  security.pam.enableU2F = true;
  security.pam.use2Factor = true;
  security.pam.u2fModuleArgs = "cue";
  security.pam.services."sudo".use2Factor = false;
}
```

*Declared by:*

> **[`<modules/nixos/yubikey/default.nix>`](../modules/nixos/yubikey/default.nix)**  

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

> **[`<modules/nixos/yubikey/default.nix>`](../modules/nixos/yubikey/default.nix)**  

*Valid in:* nixos

### security.pam.services.<name?>.use2Factor

If set to true u2f is used as 2nd factor.

*Type:* `unspecified`


*Default:* `false`

*Declared by:*

> **[`<modules/nixos/yubikey/default.nix>`](../modules/nixos/yubikey/default.nix)**  

*Valid in:* nixos

### security.pam.u2fModuleArgs

Additional arguments to pass to pam_u2f.so in all pam services.
A service definition may override this setting.


*Type:* `unspecified`


*Default:* `""`

*Example:* `"cue"`

*Declared by:*

> **[`<modules/nixos/yubikey/default.nix>`](../modules/nixos/yubikey/default.nix)**  

*Valid in:* nixos

### security.pam.use2Factor

If set to true u2f is used as 2nd factor in all pam services.
A service definition may override this setting.


*Type:* `unspecified`


*Default:* `false`

*Declared by:*

> **[`<modules/nixos/yubikey/default.nix>`](../modules/nixos/yubikey/default.nix)**  

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

*Type:* `string`



*Declared by:*

> **[`<modules/nixos/workstation/cursor.nix>`](../modules/nixos/workstation/cursor.nix)**  

*Valid in:* nixos

### services.xserver.displayManager.lightdm.greeters.gtk.cursor.package

Cursor theme package

*Type:* `package`



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

### blox.profiles.development

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

### blox.profiles.development.c.ccls

clangd package to use

*Type:* `package`


*Default:* `"llvmPackages.clang-unwrapped"`

*Declared by:*

> **[`<modules/home/development/default.nix>`](../modules/home/development/default.nix)**  

*Valid in:* home-manager

### blox.profiles.development.c.enable

Whether to enable C/C++ tooling.

*Type:* `boolean`


*Default:* `"blox.profiles.development.enable"`

*Declared by:*

> **[`<modules/home/development/default.nix>`](../modules/home/development/default.nix)**  

*Valid in:* home-manager

### blox.profiles.development.php.enable

Whether to enable PHP tooling.

*Type:* `boolean`


*Default:* `"blox.profiles.development.enable"`

*Declared by:*

> **[`<modules/home/development/default.nix>`](../modules/home/development/default.nix)**  

*Valid in:* home-manager

### blox.profiles.development.php.php-language-server

php-language-server package to use

*Type:* `package`


*Default:* `"bloxpkgs.phpPackages.php-language-server"`

*Declared by:*

> **[`<modules/home/development/default.nix>`](../modules/home/development/default.nix)**  

*Valid in:* home-manager

### blox.profiles.development.python.enable

Whether to enable Python (2 and 3) tooling.

*Type:* `boolean`


*Default:* `"blox.profiles.development.enable"`

*Declared by:*

> **[`<modules/home/development/default.nix>`](../modules/home/development/default.nix)**  

*Valid in:* home-manager

### blox.profiles.development.python.pyls

pyls environment for Python 3

*Type:* `unspecified`


*Default:* 
```nix
python.withPackages (ps: with ps; [
  flake8
  pylama
  pylint
  importmagic
  python-language-server
  pyls-black
  pyls-isort
  pyls-mypy
])
```


*Declared by:*

> **[`<modules/home/development/default.nix>`](../modules/home/development/default.nix)**  

*Valid in:* home-manager

### blox.profiles.development.rust.enable

Whether to enable Rust tooling.

*Type:* `boolean`


*Default:* `"blox.profiles.development.enable"`

*Declared by:*

> **[`<modules/home/development/default.nix>`](../modules/home/development/default.nix)**  

*Valid in:* home-manager

### blox.profiles.development.rust.rls

rls package to use

*Type:* `package`


*Default:* `"rls"`

*Declared by:*

> **[`<modules/home/development/default.nix>`](../modules/home/development/default.nix)**  

*Valid in:* home-manager

### blox.profiles.development.tools.enable

Whether to enable miscellaneous tools.

*Type:* `boolean`


*Default:* `"blox.profiles.development.enable"`

*Declared by:*

> **[`<modules/home/development/default.nix>`](../modules/home/development/default.nix)**  

*Valid in:* home-manager

### blox.profiles.doom-emacs.doomPrivateDir

Directory containing customizations, `init.el`, `config.el` and `packages.el`


*Type:* `unspecified`


*Default:* `"/nix/store/990d2crzaa9kzcdpaz1v3vss7v1lisil-doom.d"`

*Declared by:*

> **[`<modules/home/doom-emacs/default.nix>`](../modules/home/doom-emacs/default.nix)**  

*Valid in:* home-manager

### blox.profiles.doom-emacs.enable

Whether to enable Doom Emacs configuration.

*Type:* `boolean`


*Default:* `false`

*Declared by:*

> **[`<modules/home/doom-emacs/default.nix>`](../modules/home/doom-emacs/default.nix)**  

*Valid in:* home-manager

### blox.profiles.doom-emacs.extraConfig

Extra configuration options to pass to doom-emacs

*Type:* `strings concatenated with "\n"`


*Default:* `""`

*Declared by:*

> **[`<modules/home/doom-emacs/default.nix>`](../modules/home/doom-emacs/default.nix)**  

*Valid in:* home-manager

### blox.profiles.doom-emacs.extraPackages

Extra packages to install

*Type:* `list of packages`


*Default:* `[]`

*Declared by:*

> **[`<modules/home/doom-emacs/default.nix>`](../modules/home/doom-emacs/default.nix)**  

*Valid in:* home-manager

### blox.profiles.keepass.enable

Whether to enable KeePass with plugins.

*Type:* `boolean`


*Default:* `false`

*Declared by:*

> **[`<modules/home/keepass.nix>`](../modules/home/keepass.nix)**  

*Valid in:* home-manager

### blox.profiles.workstation.awesome.configure

Whether to configure Awesome WM to blox defaults.

*Type:* `boolean`


*Default:* `true`

*Declared by:*

> **[`<modules/home/workstation/awesome/default.nix>`](../modules/home/workstation/awesome/default.nix)**  

*Valid in:* home-manager

### blox.profiles.workstation.awesome.enable

Whether to install Awesome WM.

*Type:* `boolean`


*Default:* `true`

*Declared by:*

> **[`<modules/home/workstation/awesome/default.nix>`](../modules/home/workstation/awesome/default.nix)**  

*Valid in:* home-manager

### blox.profiles.workstation.compositor.enable

Whether to enable compositing.

*Type:* `boolean`


*Default:* `"!nixosConfig.system.build.vm"`

*Declared by:*

> **[`<modules/home/workstation/compositor/default.nix>`](../modules/home/workstation/compositor/default.nix)**  

*Valid in:* home-manager

### blox.profiles.workstation.light-locker.enable

Whether to use light-locker for screen locking

*Type:* `boolean`


*Default:* `true`

*Declared by:*

> **[`<modules/home/workstation/default.nix>`](../modules/home/workstation/default.nix)**  

*Valid in:* home-manager

# See Also

[`configuration.nix(5)`](https://nixos.org/nixos/manual/options.html),
[`home-configuration.nix(5)`](https://rycee.gitlab.io/home-manager/options.html)
