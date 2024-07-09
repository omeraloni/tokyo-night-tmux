#!/usr/bin/env bash

SELECTED_THEME="$(tmux show-option -gv @tokyo-night-tmux_theme)"

case $SELECTED_THEME in
"storm")
  declare -A THEME=(
    ["background"]="#24283b"
    ["foreground"]="#a9b1d6"
    ["black"]="#414868"
    ["blue"]="#7aa2f7"
    ["cyan"]="#7dcfff"
    ["green"]="#73daca"
    ["magenta"]="#bb9af7"
    ["red"]="#f7768e"
    ["white"]="#a9b1d6"
    ["yellow"]="#e0af68"

    ["bblack"]="#414868"
    ["bblue"]="#7aa2f7"
    ["bcyan"]="#7dcfff"
    ["bgreen"]="#41a6b5"
    ["bmagenta"]="#bb9af7"
    ["bred"]="#f7768e"
    ["bwhite"]="#787c99"
    ["byellow"]="#e0af68"
  )
  ;;

"day")
  declare -A THEME=(
    ["background"]="#d5d6db"
    ["foreground"]="#343b58"
    ["black"]="#0f0f14"
    ["blue"]="#34548a"
    ["cyan"]="#0f4b6e"
    ["green"]="#33635c"
    ["magenta"]="#5a4a78"
    ["red"]="#8c4351"
    ["white"]="#343b58"
    ["yellow"]="#8f5e15"

    ["bblack"]="#9699a3"
    ["bblue"]="#34548a"
    ["bcyan"]="#0f4b6e"
    ["bgreen"]="#33635c"
    ["bmagenta"]="#5a4a78"
    ["bred"]="#8c4351"
    ["bwhite"]="#343b58"
    ["byellow"]="#8f5815"
  )
  ;;

*)
  # Default to night theme
  declare -A THEME=(
    ["background"]="#1A1B26"
    ["foreground"]="#a9b1d6"
    ["black"]="#414868"
    ["blue"]="#7aa2f7"
    ["cyan"]="#7dcfff"
    ["green"]="#73daca"
    ["magenta"]="#bb9af7"
    ["red"]="#f7768e"
    ["white"]="#c0caf5"
    ["yellow"]="#e0af68"

    ["bblack"]="#2A2F41"
    ["bblue"]="#7aa2f7"
    ["bcyan"]="#7dcfff"
    ["bgreen"]="#41a6b5"
    ["bmagenta"]="#bb9af7"
    ["bred"]="#ff9e64"
    ["bwhite"]="#787c99"
    ["byellow"]="#e0af68"
  )
  ;;
esac

THEME['ghgreen']="#3fb950"
THEME['ghmagenta']="#A371F7"
THEME['ghred']="#d73a4a"
THEME['ghyellow']="#d29922"

RESET="#[fg=${THEME[foreground]},bg=${THEME[background]},nobold,noitalics,nounderscore,nodim]"

# Defaults
default_segment_seperator_datetime=""
default_segment_seperator_left=""
default_segment_seperator_right="░"
default_prefix_off="blue"
default_prefix_on="blue"
default_message_style_bg_color="blue"
default_message_style_fg_color="background"
default_prefix_on_icon="󰠠"
default_prefix_off_icon="󰤂"
default_shell_icon=""
default_ssh_icon="󰣀"
default_last_flag_icon="󰁯"

# Load alternate options
THEME['segment_seperator_datetime']=$(tmux show-option -gv @tokyo-night-tmux_segment_seperator_datetime 2>/dev/null)
THEME['segment_seperator_right']=$(tmux show-option -gv @tokyo-night-tmux_segment_seperator_right 2>/dev/null)
THEME['segment_seperator_left']=$(tmux show-option -gv @tokyo-night-tmux_segment_seperator_left 2>/dev/null)
THEME['prefix_off']=$(tmux show-option -gv @tokyo-night-tmux_prefix_off 2>/dev/null)
THEME['prefix_on']=$(tmux show-option -gv @tokyo-night-tmux_prefix_on 2>/dev/null)
THEME['message_style_bg']=$(tmux show-option -gv @tokyo-night-tmux_message_style_bg_color 2>/dev/null)
THEME['message_style_fg']=$(tmux show-option -gv @tokyo-night-tmux_message_style_fg_color 2>/dev/null)
THEME['prefix_on_icon']=$(tmux show-option -gv @tokyo-night-tmux_prefix_on_icon 2>/dev/null)
THEME['prefix_off_icon']=$(tmux show-option -gv @tokyo-night-tmux_prefix_off_icon 2>/dev/null)
THEME['shell_icon']=$(tmux show-option -gv @tokyo-night-tmux_shell_icon 2>/dev/null)
THEME['ssh_icon']=$(tmux show-option -gv @tokyo-night-tmux_ssh_icon 2>/dev/null)
THEME['last_flag_icon']=$(tmux show-option -gv @tokyo-night-tmux_last_flag_icon 2>/dev/null)

THEME['segment_seperator_datetime']="${THEME['segment_seperator_datetime']:-$default_segment_seperator_datetime}"
THEME['segment_seperator_left']="${THEME['segment_seperator_left']:-$default_segment_seperator_left}"
THEME['segment_seperator_right']="${THEME['segment_seperator_right']:-$default_segment_seperator_right}"
THEME['prefix_off']="${THEME['prefix_off']:-$default_prefix_off}"
THEME['prefix_on']="${THEME['prefix_on']:-$default_prefix_on}"
THEME['message_style_bg']="${THEME['message_style_bg']:-$default_message_style_bg_color}"
THEME['message_style_fg']="${THEME['message_style_fg']:-$default_message_style_fg_color}"
THEME['prefix_on_icon']="${THEME['prefix_on_icon']:-$default_prefix_on_icon}"
THEME['prefix_off_icon']="${THEME['prefix_off_icon']:-$default_prefix_off_icon}"
THEME['shell_icon']="${THEME['shell_icon']:-$default_shell_icon}"
THEME['ssh_icon']="${THEME['ssh_icon']:-$default_ssh_icon}"
THEME['last_flag_icon']="${THEME['last_flag_icon']:-$default_last_flag_icon}"
