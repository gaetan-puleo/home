{ pkgs, config, ... }: {

  # symlink


  programs.tmux = {
    enable = true;
    shell = "${pkgs.fish}/bin/fish";
    extraConfig = ''

    # remap prefix from 'C-b' to 'C-a'
    unbind C-a
    unbind C-b
    set-option -g prefix None
    set-option -g prefix2 None

    unbind -n C-h
    unbind -n C-j
    unbind -n C-k
    unbind -n C-l

    #PLUGINS

    # List of plugins
    # set -g @plugin 'tmux-plugins/tpm'
    # set -g @plugin 'tmux-plugins/tmux-resurrect'
    # set -g @plugin 'tmux-plugins/tmux-continuum'

    # Last saved environment is automatically restored when tmux is started.
    # set -g @continuum-boot 'on'

    # set -g terminal-overrides ',xterm-256color:Tc'
    # set -g default-terminal "tmux-256color"
    # set -g terminal-overrides "st-256color:Tc"
    # set-option -ga terminal-overrides ",xterm-256color:Tc"

    set-option -ga terminal-overrides ",*256col*:Tc"

    # Undercurl
    set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'  # undercurl support
    set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'  # underscore colours - needs tmux-3.0
    # set -as terminal-overrides ',xterm*:sitm=\E[3m'

    #set -g default-terminal "screen-256color"

    # Start windows and panes at 1, not 0
    set -g base-index 1
    setw -g pane-base-index 1

    # Split pane
    bind-key -n "M-\\" split-window -h
    bind-key -n M-| split-window -h
    bind-key -n M-- split-window -v
    bind-key -n M-_ split-window -v

    # Move pain
    bind-key -T copy-mode-vi 'M-h' select-pane -L
    bind-key -T copy-mode-vi 'M-j' select-pane -D
    bind-key -T copy-mode-vi 'M-k' select-pane -U
    bind-key -T copy-mode-vi 'M-l' select-pane -R

    # resize panel
    bind -r -n M-H resize-pane -L 5
    bind -r -n M-J resize-pane -D 5
    bind -r -n M-K resize-pane -U 5
    bind -r -n M-L resize-pane -R 5

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

    # zoom
    bind -n M-z resize-pane -Z

    # session
    bind -n M-s choose-session

    bind -n M-n new-session # create new session

    # kill
    bind -n M-q kill-pane
    bind -n M-Q kill-session
    set -g history-limit 10000

    # Enable mouse integration
    set -g mouse on

    # No delay for escape key press

    set -sg escape-time 0
    #abused Easy config reload
    bind-key -n M-r source-file ~/.tmux.conf \; display-message "tmux.conf reloaded."
    # bind-key -n M-i run-shell '~/.tmux/plugins/tpm/bin/install_plugins'


    if-shell "test -f ~/.config/tmux/theme.conf" "source ~/.config/tmux/theme.conf"

    # Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
    # run '~/.tmux/plugins/tpm/tpm'

    '';
  };
}
