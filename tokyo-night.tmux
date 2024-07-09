#!/usr/bin/env bash
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# title      Tokyo Night                                              +
# version    1.0.0                                                    +
# repository https://github.com/logico-dev/tokyo-night-tmux           +
# author     Lógico                                                   +
# email      hi@logico.com.ar                                         +
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPTS_PATH="$CURRENT_DIR/src"

source $SCRIPTS_PATH/themes.sh

tmux set -g status-left-length 80
tmux set -g status-right-length 150

RESET="#[fg=${THEME[foreground]},bg=${THEME[background]},nobold,noitalics,nounderscore,nodim]"

# Highlight colors
tmux set -g mode-style "fg=${THEME[bgreen]},bg=${THEME[bblack]}"

tmux set -g message-style "bg=${THEME['message_style_bg']},fg=${THEME['message_style_fg']}"
tmux set -g message-command-style "fg=${THEME[white]},bg=${THEME[black]}"

tmux set -g pane-border-style "fg=${THEME[bblack]}"
tmux set -g pane-active-border-style "fg=${THEME[blue]}"
tmux set -g pane-border-status off

tmux set -g status-style bg="${THEME[background]}"

TMUX_VARS="$(tmux show -g)"

default_window_id_style="digital"
default_pane_id_style="hsquare"
default_zoom_id_style="dsquare"

window_id_style="$(echo "$TMUX_VARS" | grep '@tokyo-night-tmux_window_id_style' | cut -d" " -f2)"
pane_id_style="$(echo "$TMUX_VARS" | grep '@tokyo-night-tmux_pane_id_style' | cut -d" " -f2)"
zoom_id_style="$(echo "$TMUX_VARS" | grep '@tokyo-night-tmux_zoom_id_style' | cut -d" " -f2)"
window_id_style="${window_id_style:-$default_window_id_style}"
pane_id_style="${pane_id_style:-$default_pane_id_style}"
zoom_id_style="${zoom_id_style:-$default_zoom_id_style}"

netspeed="#($SCRIPTS_PATH/netspeed.sh)"
cmus_status="#($SCRIPTS_PATH/music-tmux-statusbar.sh)"
git_status="#($SCRIPTS_PATH/git-status.sh #{pane_current_path})"
wb_git_status="#($SCRIPTS_PATH/wb-git-status.sh #{pane_current_path} &)"
window_number="#($SCRIPTS_PATH/custom-number.sh #I $window_id_style)"
custom_pane="#($SCRIPTS_PATH/custom-number.sh #P $pane_id_style)"
zoom_number="#($SCRIPTS_PATH/custom-number.sh #P $zoom_id_style)"
date_and_time="$($SCRIPTS_PATH/datetime-widget.sh)"
current_path="#($SCRIPTS_PATH/path-widget.sh #{pane_current_path})"
battery_status="#($SCRIPTS_PATH/battery-widget.sh)"

#+--- Left segments ---+
prefix_indicator="#[fg=${THEME[bblack]},bold]#{?client_prefix,#[bg=${THEME['prefix_on']}] ${THEME['prefix_on_icon']} ,#[bg=${THEME['prefix_off']},dim] ${THEME['prefix_off_icon']} }"
session_name="#[bold,nodim]#S #[bg=${THEME[bblack]},bold]#{?client_prefix,#[fg=${THEME['prefix_on']}],#[fg=${THEME['prefix_off']},bg=${THEME[background]}]}${THEME[segment_seperator_left]}"

tmux set -g status-left "$prefix_indicator$session_name"

#+--- Windows ---+
# Focused
tmux set -g window-status-current-format "$RESET#[fg=${THEME[background]},bg=${THEME[bblack]}]${THEME['segment_seperator_left']}#[fg=${THEME[green]},bg=${THEME[bblack]}] #{?#{==:#{pane_current_command},ssh},${THEME['ssh_icon']} ,${THEME['shell_icon']} }#[fg=${THEME[foreground]},bold,nodim]$window_number#W#[nobold]#{?window_zoomed_flag, $zoom_number, $custom_pane}#{?window_last_flag, , }#[fg=${THEME[bblack]},bg=${THEME[background]}]${THEME[segment_seperator_left]}"
# Unfocused
tmux set -g window-status-format "$RESET#[fg=${THEME[foreground]}] #{?#{==:#{pane_current_command},ssh},${THEME['ssh_icon']} ,${THEME['shell_icon']} }${RESET}$window_number#W#[nobold,dim]#{?window_zoomed_flag, $zoom_number, $custom_pane}#[fg=${THEME[yellow]}]#{?window_last_flag,${THEME['last_flag_icon']}  , }"

#+--- Right segments ---+
tmux set -g status-right "$battery_status$current_path$cmus_status$netspeed$git_status$wb_git_status$date_and_time"
tmux set -g window-status-separator ""
