#!/usr/bin/env bash

img=$(find ~/.config/wallpaper/pictures -type f | shuf -n 1)
[ -z "$img" ] && exit 0

awww img "$img" \
	--transition-type wipe \
	--transition-duration 1
