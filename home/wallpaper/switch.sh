#!/usr/bin/env bash

while true; do
	img=$(find ~/.config/wallpaper/pictures type f | shuf -n 1)

	awww img "$img" \
		--transition-type wipe \
		--transition-duration 1

	sleep 300
done
