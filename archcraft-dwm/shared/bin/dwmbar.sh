#!/bin/bash

# ^c$var^ = fg color
# ^b$var^ = bg color

interval=0

# load colors!
. ~/usr/share/archcraft/dwm/bar_themes/catppuccin

cpu() {
  cpu_val=$(grep -o "^[^ ]*" /proc/loadavg)

  printf "^c$green^ ﮣ  "
  printf "^c$green^ $cpu_val"
}

volume() {
  vol_val=$(pamixer --get-volume)

  printf "^c$peach^   "
  printf "^c$peach^ $vol_val%%"
}


pkg_updates() {
	updates=$(xbps-install -un | wc -l) # void
	# updates=$(checkupdates | wc -l)   # arch , needs pacman contrib
	# updates=$(aptitude search '~U' | wc -l)  # apt (ubuntu,debian etc)

	if [ "$updates" == "0" ]; then
		printf "^c$flamingo^  Fully Updated"
	else
		printf "^c$flamingo^  $updates"" updates"
	fi
}

mem() {
  printf "^c$mauve^^b$black^   "
  printf "^c$mauve^ $(free -h | awk '/^Mem/ { print $3 }' | sed s/i//g)"
}

player() {
  player=$(playerctl -s metadata title)
  if [ -z "$player" ]; then
    printf " "
  else
    printf "^c$red^   ${player:0:30}"
  fi
}

clock() {
  printf "^c$blue^   "
  printf "^c$blue^ $(date '+%a %I:%M %p') "
}

while true; do
  [ $interval = 0 ] || [ $(($interval % 3600)) = 0 ] && updates=$(pkg_updates)
  interval=$((interval + 1))
  space="   "
  sleep 1 && xsetroot -name "$space $(player) $space $updates $space $(volume) $space $(cpu) $space $(mem) $space $(clock) "
done
