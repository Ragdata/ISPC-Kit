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
    writeRegistry
}

writeRegistry()
{
    if [[ -f "$REG" ]]; then
        ext=$(date '+%y%m%d.%I%M')
        mv "$REG" "$REG"."$ext"
        touch "$REG"
    fi

    echo "declare -A REGISTRY=(" >> "$REG"
    for k in "${!REGISTRY[@]}"
    do
        echo "[$k]=\"${REGISTRY[$k]}\"" >> "$REG"
    done
    echo ")" >> "$REG"
}
