#-------------------------------------------------------------------
# src/inc/common.sh
#-------------------------------------------------------------------
# ISPC Kit - ISPConfig 3 Installer
#
# File:         common.sh
# Author:       Ragdata
# Date:         26/02/2021 1353
# License:      MIT License
# Copyright:    2021 ~ Aequitas Veritas Pty Ltd ~ All Rights Reserved
#-------------------------------------------------------------------
# COMMON ELEMENTS
#-------------------------------------------------------------------
# terminal colours
red='\e[0;31m'
green='\e[0;32m'
yellow='\e[0;33m'
bold='\e[1m'
italic='\e[3m'
underlined='\e[4m'
strike='\e[9m'
NC='\e[0m' # No Color
COLUMNS=$(tput cols)
# regular expressions
HOST_REGEX='^[a-z0-9][a-z0-9\-]+\.[a-z0-9\.\-]+$'
IPv4_REGEX='^((25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[0-9]?[0-9])\.?){4}$'
IPv6_REGEX='^([a-fA-F0-9]{0,4}:?){6}([a-fA-F0-9]{1,4})$'
isFlag="^\-.*"
isLoc="^[a-z]{2}_[A-Z]{2}.*$"
AFFIRM='^[Yy]$'
NEGAT='^[Nn]$'
RESP='^[YyNn]$'
# printable elements
DEFAULT_Y="[${bold}Y${NC}/N]"
DEFAULT_N="[Y/${bold}N${NC}]"
#-------------------------------------------------------------------
# PATHS
#-------------------------------------------------------------------
rootDir=~/.ispc
if [[ ! -d $rootDir ]]; then mkdir "$rootDir"; fi

configDir="$baseDir"/cfg
if [[ ! -d $configDir ]]; then mkdir "$configDir"; fi
docsDir="$baseDir"/docs
if [[ ! -d $docsDir ]]; then mkdir "$docsDir"; fi

logDir="$rootDir"/logs
if [[ ! -d $logDir ]]; then mkdir "$logDir"; fi

srcDir="$baseDir"/src
if [[ ! -d $srcDir ]]; then mkdir "$srcDir"; fi

appDir="$srcDir"/app
if [[ ! -d $appDir ]]; then mkdir "$appDir"; fi
etcDir="$srcDir"/etc
if [[ ! -d $etcDir ]]; then mkdir "$etcDir"; fi
incDir="$srcDir"/inc
if [[ ! -d $incDir ]]; then mkdir "$incDir"; fi
libDir="$srcDir"/lib
if [[ ! -d $libDir ]]; then mkdir "$libDir"; fi

sqlDir="$baseDir"/sql
if [[ ! -d $sqlDir ]]; then mkdir "$sqlDir"; fi
nginxDir="$baseDir"/cfg/nginx
if [[ ! -d $nginxDir ]]; then mkdir "$nginxDir"; fi
#- FILES -----------------------------------------------------------
DEF="$configDir"/.defaults
REG="$configDir"/.registry
#-------------------------------------------------------------------
# GLOBALS
#-------------------------------------------------------------------
declare -A PASSWORDS
