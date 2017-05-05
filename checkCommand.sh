#!/bin/bash
#comment
cmdInPath() {
	OldIFS=$IFS
	IFS=:
	local flagCmd=0
	for var in $PATH; do
		if [ -x ${var}/$1 ]; then
			echo ${var}/$1
			if [ $flagCmd = 0 ]; then
				flagCmd=1
			fi
		fi
	done
	if [ $flagCmd = 0 ]; then
		echo $1 not found.
	fi
	IFS=$OldIFS
}

pathInPath() {
	if [ -x $1 ]; then
		echo $1
	else 
		echo $1 not found.
	fi
}

checkInput() {
	local var=$1
	if [ ${var:0:1} = '/' ]; then
		pathInPath $var
	else
		cmdInPath $var
	fi
}

###MAIN###
if [ $# -lt 1 ]; then
	cat << Notify
	The number of inputs are $#.
	try again.
Notify
	exit 0
else
	for var in $*; do
		checkInput $var
	done
fi
