#!/bin/bash

set -o pipefail
set -u
set -e

CD_DRIVE=/dev/sr0
OUT_FOLDER="${1:-.}"

[[ ! -d "${OUT_FOLDER}" ]] && mkdir -p "${OUT_FOLDER}"

while true; do

	echo "hit Ctrl+C to end"
	echo ""

	# wait for system automount
	until [ "$(mount | grep ${CD_DRIVE})" != "" ]; do
		echo 'wait for drive to be ready'
		sleep 1
	done

	NAME="$(date +%d-%m-%Y_%H-%M-%S)"
	OUT_FILE="${OUT_FOLDER}/${NAME}.iso"

	echo "creating ${OUT_FILE} image"

	set +e
	dd if="${CD_DRIVE}" of="${OUT_FILE}" bs=1M
	if [ 0 != $? ]; then
		echo "errors during copy, renaming file"
		mv -v "${OUT_FILE}" "${OUT_FILE//.iso/_KO.iso}"
	fi

	set -e
	eject ${CD_DRIVE}
	echo "hit return to continue"
	read keystroke
	eject -t ${CD_DRIVE}

done
