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
#buildArray()
#{
#    if [[ $# ]]; then
#        name="$1"
#        shift
#        if grep -q "=" "$1"; then declare -A "${name}"; else declare -a "${name}"; fi
#        data=( "$@" )
#        for line in "${data[@]}"
#        do
#            if grep -q "=" "$line"; then
#                key=${line%%=*}
#                key=${key^^}
#                value=${line##*=}
#                # shellcheck disable=SC1087
#                declare "$name[$key]=$value"
#            else
#                eval "$name"+=\("$value"\)
#            fi
#        done
#    else
#        errorExit "buildArray() ERROR: No arguments passed!"
#    fi
#}

echoLog()
{
    msg=${1:-""}
    flag=${2:-""}

    if [ -z "$msg" ]; then
        errorExit "ERROR: Corwardly refusing to echo log entry with no message!"
    fi

    if [ -z "$LOG" ]; then initLog fallback; fi

    if [[ $msg == "spacer" ]]; then
        echo
        log "spacer"
    elif [[ $msg == "line" ]]; then
        echo "======================================================"
        log "line"
    elif [ -n "$flag" ]; then
        if [[ $flag == "-n" ]]; then
            echo -en "$msg"
            log "$msg" -n
        elif [[ $flag == "-c" ]]; then
            echo -e "$msg"
            log "$msg" -c
        fi
    else
        echo -e "$msg"
        log "$msg"
    fi
}

initialize()
{

}

initLog()
{
    file=${1:-"install"}

    ext=$(date '+%y%m%d.%I%M')
    LOG="$logDir"/log."$file"."$ext"
    touch "$LOG"
    log "LOG Initialised"
    log "line"
}

log()
{
    msg=${1:-""}
    flag=${2:-""}

    if [ -z "$msg" ]; then
        echo -e "${BR1}ERROR: Corwardly refusing to write log entry with no message!${_A}"
        echo
        return 1
    fi

    # shellcheck disable=SC2001
    msg=$( echo "$msg" | sed 's/\\e\[.+m//g' )

    logtime=$(date '+%y-%m-%d:%I%M%S.%3N')

    if [[ $msg == "spacer" ]]; then
        echo " " >>"$LOG"
    elif [[ $msg == "line" ]]; then
        echo "======================================================" >>"$LOG"
    elif [ -n "$flag" ]; then
        if [[ $flag == "-n" ]]; then
            echo -en "$logtime - $msg" >>"$LOG"
        elif [[ $flag == "-c" ]]; then
            echo -e "$msg" >>"$LOG"
        fi
    else
        echo -e "$logtime - $msg" >>"$LOG"
    fi
}

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

    if [ -z "$arrayName" ]; then errorExit "serialize() ERROR: No object name passed!"; fi

    fileName=${$arrayName,,}

    if [[ -f "$registry/.$fileName" ]]; then
        ext=$(date '+%y%m%d.%I%M')
        mv "$registry/.$fileName" "$registry/.$fileName.$ext"
        touch "$registry/.$fileName"
    fi

    array="${$arrayName[@]}"

    if [[ -v "${!array}" ]]; then
        for key in "${!array}"
        do
            value="$arrayName[$key]"
            echo "$key=${!value}" >> "$registry/.$fileName"
        done
    else
        errorExit "serialize() $arrayName ERROR: Object not initialized!"
    fi
}

unserialize()
{
    filePath=${1:-""}

    if [[ ! -f "$filePath" ]]; then errorExit "unserialize() $filePath ERROR: File does not exist!"; fi
}








registryInit()
{
    # initialise registry array
    declare -A REGISTRY
    # determine os release name
    if [[ ! -x /usr/bin/lsb_release ]]; then
        apt install -y lsb-release
    fi
    REGISTRY[REL]=$(lsb_release -cs)
    # get server id

}

serializeRegistry()
{
    if [[ -v REGISTRY[@] ]]; then
        for key in "${!REGISTRY[@]}"
        do
            printf '%s\0' "$key" "${REGISTRY[$key]}"
        done > "$REG"
    else
        errorExit "serializeRegistry() ERROR: REGISTRY has not been declared!"
    fi
}

unserializeRegistry()
{
    if [[ -f "$REG" ]]; then
        declare -A REGISTRY
        while IFS= read -r -d '' key && IFS= read -r -d '' value;
        do
            REGISTRY[$key]=$value
        done < "$REG"
    else
        errorExit "unserializeRegistry() ERROR: registry file does not exist!"
    fi
}




#buildRegistry()
#{
#    echoLog "Building Registry"
#    declare -A REGISTRY
#    # determine release name
#    if [[ ! -x /usr/bin/lsb_release ]]; then
#        echoLog "spacer"
#        apt_install "lsb-release"
#        echoLog "spacer"
#    fi
#    REGISTRY[REL]=$(lsb_release -cs)
#    echoLog "Release determined to be: '${REGISTRY[REL]}'"
#    echoLog "spacer"
#    # get server id
#    getId
#    # display what we know
#    serverSummary
#    # persist registry
#    writeRegistry
#}
#
#writeRegistry()
#{
#    if [[ -f "$REG" ]]; then
#        ext=$(date '+%y%m%d.%I%M')
#        mv "$REG" "$REG"."$ext"
#        touch "$REG"
#    fi
#
#    echo "declare -A REGISTRY=(" >> "$REG"
#    for k in "${!REGISTRY[@]}"
#    do
#        echo "[$k]=\"${REGISTRY[$k]}\"" >> "$REG"
#    done
#    echo ")" >> "$REG"
#}
