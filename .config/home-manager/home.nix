{ config, pkgs, ... }:

{

 imports = [ ./modules/tmux.nix ./modules/shell.nix ./modules/kitty.nix ];
  # imports = [ ./common.nix ./extra-packages.nix ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "gaetan";
  home.homeDirectory = "/home/gaetan";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs.fish
    pkgs.dejavu_fonts
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    pkgs.pomodoro
    pkgs.bottom
    pkgs.figlet
    pkgs.toilet
    pkgs.uair
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  # home.file.".config/kitty/kitty.conf" = { source = config.lib.file.mkOutOfStoreSymlink "/home/gaetan/.config/home-manager/config/kitty/kitty.conf"; };
  home.file.".config/kitty/tokyonight.conf" = { source = config.lib.file.mkOutOfStoreSymlink "/home/gaetan/.config/home-manager/config/kitty/tokyonight.conf"; };
    # ".config/tmux/tmux.conf" = { source = config.lib.file.mkOutOfStoreSymlink "/home/gaetan/.config/home-manager/config/tmux/tmux.conf"; };
  home.file.".config/tmux/theme.conf" = { source = config.lib.file.mkOutOfStoreSymlink "/home/gaetan/.config/home-manager/config/tmux/theme.conf"; };
  home.file.".config/uair/uair.toml" = { source = config.lib.file.mkOutOfStoreSymlink "/home/gaetan/.config/home-manager/config/uair/uair.toml"; };
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/gaetan/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.

  fonts.fontconfig.enable = true;
  home.sessionVariables = {
    # EDITOR = "emacs";
  };
  programs.foot = {
    server.enable = true;
    enable = true;
    settings = {
    csd = {
      size = 0;
    };
    main = {
      shell = "${pkgs.fish}/bin/fish";
      include = "${pkgs.foot.themes}/share/foot/themes/tokyonight-night";
      term = "xterm-256color";

      # font = "FiraCode Nerd Font Mono;:size=5";
      font = "FiraCode Nerd Font:pixelsize=14";
      dpi-aware = "no";

    };
    tweak = {
      font-monospace-warn = "no";
    };
  };
  };

  # As already mentioned
  targets.genericLinux.enable = true;
  xdg.mime.enable = true;

  # The critical missing piece for me
  xdg.systemDirs.data = [ "${config.home.homeDirectory}/.nix-profile/share/applications" ];
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
