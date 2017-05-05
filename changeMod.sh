#!/bin/bash
#comment
LOG_TIME=`date +'%Y-%m-%d %H:%M:%S'`
note() {
    printf "[${LOG_TIME}] $* \n"
}

changeMod() {
    if [ -d $2 ]; then
    	cd $2
    	for file in `find $2`; do
	    	if [[ $file != $2 ]]; then
		    	changeMod $1 $file
	    	fi
	    done
    fi
    chmod $1 $2
}

checkFile() {
	if [[ ! -f $1 && ! -d $1 ]]; then
		note "$1 cannot be found."
	    exit 0
	fi
}

if [[ $# -lt 1 || $# -gt 2 ]]; then
    note "The number of inputs are $#, try again."
    exit 0
fi
case $# in
1)
	checkFile $1
    changeMod 777 $1
    ;;
2)
	checkFile $2
    changeMod $1 $2
    ;;
*)
    note *
    ;;
esac
