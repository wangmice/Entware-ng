#!/bin/sh

case $1 in
	0)
		make V=99 -j 2>&1 |tee $(date +'%Y%m%d-%H').log
		;;
	1|2|3|4)
		make V=99 -j$1 2>&1 |tee $(date +'%Y%m%d-%H').log
		;;
	p)
		case $3 in
			1)
				make V=s package/$2/prepare
				;;
			3)
				make V=s package/$2/clean
				;;
			*)
				make V=s package/$2/compile 2>&1 |tee $(date +'%Y%m%d-%H').log
				;;
		esac	
		;;
	*)
		make V=99  2>&1 |tee $(date +'%Y%m%d-%H').log
	;;
esac
