{ pkgs, ... }: {
  home.shellAliases = {
    dot = "git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME";
    nuke = "rm -rf";
    md = "mkdir";
    js="nix develop github:gaetan-puleo/js-shell";
    vim="nix run github:gaetan-puleo/nvim --";
    mnt = "mount | grep -E ^/dev | column -t";
    # ssh = "kitty +kitten ssh";
    nvim = "nix run github:gaetan-puleo/nvim --";
    focus = "uair | toilet -f mono9";
    pause = "uairctl pause";
    resume = "uairctl resume";
  };
  home.sessionVariables = {
    # JAVA_HOME = "${pkgs.jdk11}";
    # ANDROID_HOME = "$HOME/Android/Sdk";
    EDITOR = "nvim";
    # VSCODE_PORTABLE="\${XDG_DATA_HOME}/vscode";
    # PATH="${pkgs.jdk11}/bin:$PATH";
    # DBX_CONTAINER_MANAGER="podman";

  };
  programs.fish.enable = true;
  programs.fish.plugins = [
    { name = "pure"; src = pkgs.fishPlugins.pure.src; }
    { name = "foreign-env"; src = pkgs.fishPlugins.foreign-env.src; }
    {
      name = "z";
      src = pkgs.fetchFromGitHub {
        owner = "jethrokuan";
        repo = "z";
        rev = "e0e1b9dfdba362f8ab1ae8c1afc7ccf62b89f7eb";
        sha256 = "0dbnir6jbwjpjalz14snzd3cgdysgcs3raznsijd6savad3qhijc";
      };
    }
    {
      name = "nix-env";
      src = pkgs.fetchFromGitHub {
        owner = "lilyball";
        repo = "nix-env.fish";
        rev = "7b65bd228429e852c8fdfa07601159130a818cfa";
        sha256 = "sha256-RG/0rfhgq6aEKNZ0XwIqOaZ6K5S4+/Y5EEMnIdtfPhk=";
      };
    }
  ];
  programs.fish.functions = {
    __fish_command_not_found_handler = {
      body = "__fish_default_command_not_found_handler $argv[1]";
      onEvent = "fish_command_not_found";
    };
  };

  programs.bash = {
    enable = true;
    initExtra = ''
    '';
    profileExtra = ''
    . /home/gaetan/.nix-profile/etc/profile.d/nix.sh
    '';
  };

}
