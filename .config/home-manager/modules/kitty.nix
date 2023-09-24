{ pkgs, config, ... }: {

  programs.kitty = {
    enable = false;
    font.size = 11;
    font.name = "FiraCode Nerd Font";
    theme = "Tokyo Night";
    settings = {
      # fonts
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";

      term = "xterm-256color";
      enable_audio_bell = "no"; # silent bell
      shell = "${pkgs.fish} --interactive --login";
      dynamic_background_opacity = "true";
      /* background_opacity = "0.90"; */
      background_opacity = "0.99";
      confirm_os_window_close = "0";

      # use the option as alt key in mac because mac is stupid to not di it by default
      #macos_option_as_alt yes
      placement_strategy = "top-left";

      #ilinux_display_server = "x11";

      hide_window_decorations = true;
    };
  };
}
