# nvim Configs


## tmux config (~/.tmux.conf)
```
source-file "${HOME}/.tmux-themepack/powerline/block/cyan.tmuxtheme"
set -sg escape-time 10
unbind C-b
set-option -g prefix C-a
bind-key C-a send-prefix

#smart pane switching with awareness of vim splits
bind -n C-h run "(tmux display-message -p '#{pane_current_command}' | grep -iqE '(^|\/)nvim$' && tmux send-keys C-h) || tmux select-pane -L"
bind -n C-j run "(tmux display-message -p '#{pane_current_command}' | grep -iqE '(^|\/)nvim$' && tmux send-keys C-j) || tmux select-pane -D"
bind -n C-k run "(tmux display-message -p '#{pane_current_command}' | grep -iqE '(^|\/)nvim$' && tmux send-keys C-k) || tmux select-pane -U"
bind -n C-l run "(tmux display-message -p '#{pane_current_command}' | grep -iqE '(^|\/)nvim$' && tmux send-keys C-l) || tmux select-pane -R"
bind -n C-\\ run "(tmux display-message -p '#{pane_current_command}' | grep -iqE '(^|\/)nvim$' && tmux send-keys 'C-\\') || tmux select-pane -l"
bind C-l send-keys 'C-l'

bind-key [ copy-mode
#bind-key p paste-buffer

bind-key -T copy-mode-vi 'v' send -X begin-selection
bind-key -T copy-mode-vi 'y' send -X copy-selection-and-cancel

setw -g mode-keys vi
set-option -g default-terminal screen-256color

bind-key : command-prompt
bind-key r refresh-client
bind-key L clear-history

bind-key space next-window
bind-key bspace previous-window
bind-key enter next-layout

bind-key v split-window -h
bind-key s split-window -v

#Allow the arrow key to be used immediately after changing windows
set-option -g repeat-time 0
```
