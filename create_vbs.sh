#!/bin/bash

#Path(LINUX) to directory of rclone config file
	#Example:
	#	CONF_FILE="/mnt/c/Users/danwa/.config/rclone"
	CONF_FILE=$HOME/.config/rclone

#Path(Windows) to mounting folder(folder must exist)
	#Example:
	#	DIR="D:\\SFTP"
	DIR="D:\\SFTP"

#Path(Linux) to mounting script with his name and format (must be .vbs)
	#Example:
	#	OUTPUT="/mnt/c/Users/danwa/.config/rclone/mount_windows.vbs"
	OUTPUT="mount_windows.vbs"

echo 'Set WshShell = CreateObject("WScript.Shell")' > $OUTPUT

for disk in $(cat "$CONF_FILE/rclone.conf" | grep -E '\[.*\]' | sed 's/\[//;s/\]//;s/\r$//' | tr -d '\r');
	do
		echo 'WshShell.Run "cmd /K rclone --vfs-cache-mode writes --dir-cache-time 5s mount '"$disk: $DIR\\$disk"'", 0' >> $OUTPUT
	done

echo 'Set WshShell = Nothing' >> $OUTPUT