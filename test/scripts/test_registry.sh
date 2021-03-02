#!/bin/bash
#-------------------------------------------------------------------
# test/scripts/test_libs.sh
#-------------------------------------------------------------------
# ISPC Kit - ISPConfig 3 Installer
#
# File:         test_libs.sh
# Author:       Ragdata
# Date:         02/03/2021 0348
# License:      MIT License
# Copyright:    2021 ~ Aequitas Veritas Pty Ltd ~ All Rights Reserved
#-------------------------------------------------------------------
# INITIALISE
#-------------------------------------------------------------------
arrayName=${1:-""}
arrayName=${arrayName^^}
baseDir="./../.."
#-------------------------------------------------------------------
# LOAD LIBRARIES
#-------------------------------------------------------------------
. "$baseDir/src/lib/common.sh" || exit 1
. "$formats" || exit 1
. "$functions" || exit 1
. "$logger" || exit 1
. "$register" || exit 1
. "$yaml" || exit 1
#-------------------------------------------------------------------
# MAIN TEST
#-------------------------------------------------------------------
# initialise registry
declare -A REGISTRY
# assign a few variables
REGISTRY[LOC]="en_AU.UTF-8"
REGISTRY[EMAIL]="admin@aever.net"
REGISTRY[IP]="192.168.0.1"
# serialize the registry
# shellcheck disable=SC1087
array="$arrayName[@]"
echo "$array"
echo "${!array}"
serialize REGISTRY || exit 1
# unset the registry(?)
unset REGISTRY || exit 1
# print the file just for shits'n'giggles
if [[ ! -f "$registry/.registry" ]]; then exit 1;
else cat "$registry/.registry"; fi
# unserialize the registry
unserialize "$registry/.registry" || exit 1
# check that an expected variable exists
if [[ ${REGISTRY[LOC]} != "en_AU.UTF-8" ]]; then exit 1; fi
# SUCCESS!
exit 0;
