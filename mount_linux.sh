#!/bin/bash

#Path to mounting folder
	#Example:
	#	DIR="$HOME/SFTP"
	
DIR="$HOME/SFTP"

for disk in $(cat "$HOME/.config/rclone/rclone.conf" | grep -E '\[.*\]' | sed 's/\[//;s/\]//;s/\r$//' | tr -d '\r');
do
	if [ ! -d "$DIR/$disk" ]; then
		echo 'Created directory:'
  		echo "$DIR/$disk"
		mkdir -p "$DIR/$disk"
	fi
	rclone --daemon --vfs-cache-mode=writes --dir-cache-time=5s mount "$disk:" "$DIR/$disk"
done