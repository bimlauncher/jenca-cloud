#!/bin/bash -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

usage() {
cat <<EOF
Usage:
images.sh build
images.sh help
EOF
	exit 1
}

cmd-build-image() {
	local repo=$1;
	cd ${DIR}/../repos/${repo} && make images
}

cmd-build-images() {
	local repodir="${DIR}/../repos/*"
	for dir in $(ls -d $repodir); 
  do
  	if [[ -d $dir ]]; then
    	cmd-build-image `basename $dir`
    fi
  done
}

main() {
	case "$1" in
	build)					      shift; cmd-build-images; $@;;
	*)                    usage $@;;
	esac
}

main "$@"
