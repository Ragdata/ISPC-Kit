#-------------------------------------------------------------------
# src/inc/registry.sh
#-------------------------------------------------------------------
# ISPC Kit - ISPConfig 3 Installer
#
# File:         registry.sh
# Author:       Ragdata
# Date:         26/02/2021 1353
# License:      MIT License
# Copyright:    2021 ~ Aequitas Veritas Pty Ltd ~ All Rights Reserved
#-------------------------------------------------------------------
# INIT
#-------------------------------------------------------------------
RES=0
#-------------------------------------------------------------------
# FUNCTIONS
#-------------------------------------------------------------------
buildRegistry()
{
    echoLog "Building Registry"
    declare -A REGISTRY
    # determine release name
    if [[ ! -x /usr/bin/lsb_release ]]; then
        echoLog "spacer"
        apt_install "lsb-release"
        echoLog "spacer"
    fi
    REGISTRY[REL]=$(lsb_release -cs)
    echoLog "Release determined to be: '${REGISTRY[REL]}'"
    echoLog "spacer"
    # get server id
    getId
    # display what we know
    serverSummary
    # persist registry
    sleepRegistry
}

sleepRegistry()
{
    if [[ -f "$REG" ]]; then
        ext=$(date '+%y%m%d.%I%M')
        mv "$REG" "$REG"."$ext"
        touch "$REG"
    fi
    for k in "${!REGISTRY[@]}"
    do
        echo "$k=\"${REGISTRY[$k]}\"" >> "$REG"
    done
    # add an empty line to the bottom of the file just to make SURE that it's there
    echo " " >> "$REG"
}

wakeRegistry()
{
    if [[ ! -f "$REG" ]]; then
        errorExit "ERROR: Registry file does not exist!"
    fi
    if [[ $flag == "test" ]]; then
       echo "wakeRegistry()"
       echo -n "Press [ENTER] to continue"
       read -n 1 -r
    fi
    declare -A REGISTRY

    while IFS='' read -r LINE || [ -n "${LINE}" ]; do
        REGISTRY[${LINE%%=*}]=${LINE#*=}
    done < "$REG"
}
#-------------------------------------------------------------------
# MAIN
#-------------------------------------------------------------------
initLog
if [[ -f "$REG" ]]; then wakeRegistry; else buildRegistry; fi
