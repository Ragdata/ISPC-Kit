#-------------------------------------------------------------------
# src/lib/registry.sh
#-------------------------------------------------------------------
# ISPC Kit - Registry Module
#
# File:         registry.sh
# Author:       Ragdata
# Date:         26/02/2021 1353
# License:      MIT License
# Copyright:    2021 ~ Aequitas Veritas Pty Ltd ~ All Rights Reserved
#-------------------------------------------------------------------
# CONFIG
#-------------------------------------------------------------------

#-------------------------------------------------------------------
# FUNCTIONS
#-------------------------------------------------------------------
scribe()
{
    if [[ $# ]]; then
        if [[ $1 =~ $isPath ]]; then local filePath=$1; shift; fi
        if [ -z "$filePath" ]; then errorExit "scribe() ERROR: No path given!";
        elif [ -n "$filePath" ] && [[ ! -f "$filePath" ]]; then errorExit "scribe() ERROR: $filePath is not a file!";
        elif [ -n "$filePath" ] && [[ -f "$filePath" && -w "$filePath" ]]; then errorExit "scribe() ERROR: Write permission denied on $filePath"; fi

        for line in "$@"
        do
            echo "$line" >> "$filePath"
        done
    else
        errorExit "scribe() ERROR: No arguments passed!"
    fi
}

serialize()
{
    arrayName=${1:-""}
    arrayName=${arrayName^^}

    if [ -z "$arrayName" ]; then errorExit "serialize() ERROR: No object name passed!"; fi

    fileName=${arrayName,,}

    if [[ -f "$registry/.$fileName" ]]; then
        ext=$(date '+%y%m%d.%I%M')
        mv "$registry/.$fileName" "$registry/.$fileName.$ext"
        touch "$registry/.$fileName"
    fi

    # shellcheck disable=SC1087
    array="$arrayName[@]"

    if [[ -v "${!array}" ]]; then
        for key in "${!array}"
        do
            # shellcheck disable=SC1087
            value="$arrayName[$key]"
            echo "$key=${!value}" >> "$registry/.$fileName"
        done
    else
        errorExit "serialize() $arrayName ERROR: Object not initialized!"
    fi
}

unserialize()
{
#!/bin/bash
    filePath=${1:-""}
    skipZero=${2:-1}

    if [[ ! -f "$filePath" ]]; then errorExit "unserialize() $filePath ERROR: File does not exist!"; fi

    fileName="${filePath##*/}"
    arrayName="${fileName:1}"
    arrayName="${arrayName^^}"

    declare -A "$arrayName"

    while IFS=$'\n' read -r line
    do
        key=${line%%=*}
        val=${line##*=}
        # shellcheck disable=SC1087
        arrayElem="$arrayName[$key]"
        if [[ "$skipZero" == 1 ]] && [[ -n "$val" && "$val" != 0 ]]; then "${!arrayElem}"="$val"; fi
    done < "$filePath"
}
