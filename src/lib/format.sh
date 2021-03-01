#-------------------------------------------------------------------
# src/lib/format.sh
#-------------------------------------------------------------------
# Bash Terminal Formatting Library (ANSI/VT100)
#
# File:         format.sh
# Author:       Ragdata
# Date:         01/03/2021 0502
# License:      MIT License
# Copyright:    2021 ~ Aequitas Veritas Pty Ltd ~ All Rights Reserved
#-------------------------------------------------------------------
# VARIABLES
#-------------------------------------------------------------------
# reset
_A='\e[0m'

# regular colors
N0='\e[0;30m'       # black
N1='\e[0;31m'       # red
N2='\e[0;32m'       # green
N3='\e[0;33m'       # yellow
N4='\e[0;34m'       # blue
N5='\e[0;35m'       # purple
N6='\e[0;36m'       # cyan
N7='\e[0;37m'       # white

# bright colors
BR0='\e[0;90m'      # bright black
BR1='\e[0;91m'      # bright red
BR2='\e[0;92m'      # bright green
BR3='\e[0;93m'      # bright yellow
BR4='\e[0;94m'      # bright blue
BR5='\e[0;95m'      # bright purple
BR6='\e[0;96m'      # bright cyan
BR7='\e[0;97m'      # bright white

# bold colors
BO0='\e[0;30m'      # bold black
BO0='\e[0;31m'      # bold red
BO0='\e[0;32m'      # bold green
BO0='\e[0;33m'      # bold yellow
BO0='\e[0;34m'      # bold blue
BO0='\e[0;35m'      # bold purple
BO0='\e[0;36m'      # bold cyan
BO0='\e[0;37m'      # bold white

# background colors
BA0='\e[0;40m'      # background black
BA0='\e[0;41m'      # background red
BA0='\e[0;42m'      # background green
BA0='\e[0;43m'      # background yellow
BA0='\e[0;44m'      # background blue
BA0='\e[0;45m'      # background purple
BA0='\e[0;46m'      # background cyan
BA0='\e[0;47m'      # background white

# bright background colors
BB0='\e[0;100m'     # bright background black
BB0='\e[0;101m'     # bright background red
BB0='\e[0;102m'     # bright background green
BB0='\e[0;103m'     # bright background yellow
BB0='\e[0;104m'     # bright background blue
BB0='\e[0;105m'     # bright background purple
BB0='\e[0;106m'     # bright background cyan
BB0='\e[0;107m'     # bright background white

# format
FBB=' \e[1m'        # format bold bright
_FBB='\e[21m'       # reset bold bright
FD=' \e[2m'         # format dim
_FD='\e[22m'        # reset dim
FU=' \e[4m'         # format underline
_FU='\e[24m'        # reset underline
FI=' \e[7m'         # format invert
_FI='\e[27m'        # reset invert
FH=' \e[8m'         # format hide
_FH='\e[28m'        # reset hide

COLUMNS=$(tput cols)
#-------------------------------------------------------------------
# FUNCTIONS
#-------------------------------------------------------------------
