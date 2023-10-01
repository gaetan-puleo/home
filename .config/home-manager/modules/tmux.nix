{ pkgs, config, ... }: {

  # symlink


  programs.tmux = {
    enable = true;
    shell = "${pkgs.fish}/bin/fish";
    extraConfig = ''

    # remove prefix2
    set-option -g prefix2 None
    set-option -g prefix None

    # set-option -g prefix C-a
    # Remove the old prefix
    unbind C-b
    unbind C-a

    # Send Ctrl+a to applications by pressing it twice
    bind C-a send-prefix

    unbind -n C-h
    unbind -n C-j
    unbind -n C-k
    unbind -n C-l



    set-option -g default-terminal 'tmux-256color'
    set -as terminal-overrides ",xterm*:Tc"

    # Start windows and panes at 1, not 0
    set -g base-index 1
    setw -g pane-base-index 1

    # Split pane
    bind-key -n "M-\\" split-window -h -c "#{pane_current_path}"
    bind-key -n M-| split-window -h -c "#{pane_current_path}"
    bind-key -n M-- split-window -v -c "#{pane_current_path}"
    bind-key -n M-_ split-window -v -c "#{pane_current_path}"

    # Move pane
    bind-key -T copy-mode-vi 'M-h' select-pane -L
    bind-key -T copy-mode-vi 'M-j' select-pane -D
    bind-key -T copy-mode-vi 'M-k' select-pane -U
    bind-key -T copy-mode-vi 'M-l' select-pane -R

    # resize panel
    bind -r -n M-H resize-pane -L 5
    bind -r -n M-J resize-pane -D 5
    bind -r -n M-K resize-pane -U 5
    bind -r -n M-L resize-pane -R 5

    bind-key -n M-1 selectw -t 1
    bind-key -n M-2 selectw -t 2
    bind-key -n M-3 selectw -t 3
    bind-key -n M-4 selectw -t 4
    bind-key -n M-5 selectw -t 5
    bind-key -n M-6 selectw -t 6
    bind-key -n M-7 selectw -t 7
    bind-key -n M-8 selectw -t 8
    bind-key -n M-9 selectw -t 9
    bind-key -n M-8 selectw -t 8

    # zoom
    bind -n M-z resize-pane -Z

    # session
    bind -n M-s choose-window
    bind -n M-S choose-session

    bind -n M-n new-window -c "#{pane_current_path}" # create new session
    bind -n M-N new-session -c "#{pane_current_path}" # create new session

    # kill
    bind -n M-q kill-pane
    bind -n M-Q kill-session
    set -g history-limit 10000

    # detach
    bind -n M-d detach


    # Enable mouse integration
    set -g mouse on

    # No delay for escape key press

    set -sg escape-time 0
    #abused Easy config reload

    bind -n M-r source-file ~/.config/tmux/tmux.conf
    source-file ~/.config/tmux/theme.conf

    '';
    plugins = with pkgs;  [
      {
        plugin = tmuxPlugins.vim-tmux-navigator;
        extraConfig = ''

        is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
            | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"
        bind-key -n 'M-h' if-shell "$is_vim" 'send-keys M-h'  'select-pane -L'
        bind-key -n 'M-j' if-shell "$is_vim" 'send-keys M-j'  'select-pane -D'
        bind-key -n 'M-k' if-shell "$is_vim" 'send-keys M-k'  'select-pane -U'
        bind-key -n 'M-l' if-shell "$is_vim" 'send-keys M-l'  'select-pane -R'
        tmux_version='$(tmux -V | sed -En "s/^tmux ([0-9]+(.[0-9]+)?).*/\1/p")'

        if-shell -b '[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]' \
            "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\'  'select-pane -l'"
        if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]' \
            "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\\\'  'select-pane -l'"

        '';
      }
      # {
      #   plugin = tmuxPlugins.resurrect;
      # }

      # {
      #   plugin = tmuxPlugins.continuum;
      #   extraConfig = ''
      #     set -g @continuum-restore 'on'
      #     set -g @continuum-save-interval '1'
      #   '';
      # }
    ];
  };
}
