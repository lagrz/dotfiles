#!/bin/bash
#cd "$(dirname "$0")"

function doIt() {
	rsync --exclude "etc/" --exclude ".git/" --exclude ".DS_Store" --exclude "sync.sh" --exclude "readme.md" -av . ~
}
if [ "$1" == "--force" -o "$1" == "-f" ]; then
	doIt
elif ["$1" == "--update" -o "$1" == "-o"]; then
	doIt
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
	echo
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		git pull
		git submodule init
		git submodule update
		doIt
	fi
fi
unset doIt
source ~/.bash_profile
