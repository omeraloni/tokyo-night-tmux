#!/usr/bin/env bash
#<------------------------------Connectivity widget for TMUX------------------------------------>
# author : @omeraloni
# email : omeraloni@duck.com
#<------------------------------------------------------------------------------------------>

# Check if enabled
ENABLED=$(tmux show-option -gv @tokyo-night-tmux_show_connecivity 2>/dev/null)
[[ ${ENABLED} -ne 1 ]] && exit 0

# Imports
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/.."
source "$ROOT_DIR/src/themes.sh"

INTERNET_TEST_ADDR="https://google.com"
LOCAL_NETWORK_TEST_ADDR="https://gitlab.solaredge.com"

VPN_CONNECTED="ifconfig | egrep -A1 ppp0 | grep inet"
INTERNET_CONNECTED="curl -m 3 -s -o /dev/null -w "%{http_code}" $INTERNET_TEST_ADDR"
LOCAL_NETWORK_CONNECTED="curl -m 3 -s -o /dev/null -w "%{http_code}" $LOCAL_NETWORK_TEST_ADDR"

get_connectivity_status() {
  if [ -n "$INTERNET_TEST_ADDR" ] && [ "$(eval "$INTERNET_CONNECTED")" -eq "000" ]; then
    echo "󰦜"
  elif [ -n "$(eval "$VPN_CONNECTED")" ]; then
    echo "󰳌"
  elif [ -n "$LOCAL_NETWORK_TEST_ADDR" ] && [ ! "$(eval "$LOCAL_NETWORK_CONNECTED")" -eq "000" ]; then
    echo "󱦛"
  else
    echo "󰒙"
  fi

}

CONNECTIVITY_STATUS=$(get_connectivity_status)

echo "${RESET}${THEME['segment_seperator_right']} #[fg=${THEME[foreground]}]$CONNECTIVITY_STATUS "
