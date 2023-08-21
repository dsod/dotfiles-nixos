#!/usr/bin/env sh

set -e
hx_bin=$(which hx)
nnn_window_id=$KITTY_WINDOW_ID
hx_window_id=$(kitty @ ls | jq -r ".[] | select(.tabs[].windows[].id == $KITTY_WINDOW_ID) | .tabs[].windows[] | select(.foreground_processes[].cmdline[] == \"$hx_bin\").id")

paths=$(nnn -P p -p -)
[[ -z $paths ]] && exit 1

if [ -z "$hx_window_id" ]; then
  if [[ $(grep -c "^" <<< $paths) > 1 ]]; then
    window_target="os-window"
  else
    window_target="window"
  fi
  for path in $paths; do
    kitty @ launch --type=$window_target hx $path
  done
else
  for path in $paths; do
    kitty @ send-text --match "id:$hx_window_id" ":open $path\r"
  done
fi  

kitty @ close-window --match "id:$nnn_window_id"
