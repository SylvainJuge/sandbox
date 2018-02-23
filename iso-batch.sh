#!/bin/bash

CD_DRIVE=/dev/cdrom
OUT_FOLDER="${1:-.}"


while true; do

	echo "hit Ctrl+C to end"
	echo ""

	NAME="$(date +%d-%m-%Y_%H-%M-%S)"
	OUT_FILE="${OUT_FOLDER}/${NAME}.iso"

	echo dd if="${CD_DRIVE}" of="${OUT_FILE}"
	eject ${CD_DRIVE}
	sleep 5
	eject -t ${CD_DRIVE}

done
