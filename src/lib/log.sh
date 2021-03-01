#-------------------------------------------------------------------
# src/lib/log.sh
#-------------------------------------------------------------------
# ISPC-Kit - Logging Module
#
# File:         log.sh
# Author:       Ragdata
# Date:         26/02/2021 1353
# License:      MIT License
# Copyright:    2021 ~ Aequitas Veritas Pty Ltd ~ All Rights Reserved
#-------------------------------------------------------------------
# FUNCTIONS
#-------------------------------------------------------------------
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

