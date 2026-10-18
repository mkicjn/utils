#!/bin/sh

TARGET_FILE=".save_location"

backup () {
	# Back up target
	if [ ! -e "$1" ]; then
		echo "No original ($1) to back up"
		exit 1
	fi
	echo "Back up $1 to $2? ^C to cancel"
	read || exit

	[ -e "$2" ] && rm "$2"
	tar czf "$2" -C "$(dirname "$1")" "$(basename "$1")"
	echo "Backed up $1 to $2"
}

restore () {
	# Restore from backup
	if [ ! -e "$2" ]; then
		echo "No backup ($2) to restore"
		exit 1
	fi
	echo "Restore $1 from $2? ^C to cancel"
	read || exit

	[ -e "$1" ] && rm -r "$1"
	tar xzf "$2" -C "$(dirname "$1")" "$(basename "$1")"
	echo "Restored $1 from $2"
}

if [ "$(basename "$0")" != "backup" -a "$(basename "$0")" != "restore" ]; then
	echo "Script expects to be called 'backup' or 'restore'"
	exit 1
fi

TARGET="$(cat $TARGET_FILE)"
if [ -z "$TARGET" ]; then
	echo "No $TARGET_FILE found"
	exit 1
fi

if [ $# -gt 0 ]; then
	$(basename "$0") "$TARGET" "$1.tar.gz"
else
	$(basename "$0") "$TARGET" "$(basename "$TARGET").tar.gz"
fi
