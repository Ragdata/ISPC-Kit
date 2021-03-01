#!/bin/bash
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
# regular expressions
HOST_REGEX='^[a-z0-9][a-z0-9\-]+\.[a-z0-9\.\-]+$'
IPv4_REGEX='^((25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[0-9]?[0-9])\.?){4}$'
IPv6_REGEX='^([a-fA-F0-9]{0,4}:?){6}([a-fA-F0-9]{1,4})$'
isFlag="^\-.*"
isLoc="^[a-z]{2}_[A-Z]{2}.*$"
isPath="^(/[^/]*)*(/?.+(\..+))$"
AFFIRM='^[Yy]$'
NEGAT='^[Nn]$'
RESP='^[YyNn]$'
# printable elements
DEFAULT_Y="[${FBB}Y${_A}/N]"
DEFAULT_N="[Y/${FBB}N${_A}]"
#-------------------------------------------------------------------
# PATHS
#-------------------------------------------------------------------
rootDir=/root/.ispc
if [[ ! -d $rootDir ]]; then mkdir "$rootDir"; fi
logDir="$rootDir/logs"
if [[ ! -d $logDir ]]; then mkdir "$logDir"; fi
#- registry --------------------------------------------------------
registry="$baseDir/registry"
if [[ ! -h $registry ]]; then ln -s "$rootDir" "$registry"; fi
#- config ----------------------------------------------------------
cfgDir="$baseDir/cfg"
nginxDir="$cfgDir/nginx"
#- docs ------------------------------------------------------------
docsDir="$baseDir/docs"
#- src -------------------------------------------------------------
srcDir="$baseDir/src"
etcDir="$srcDir/etc"
libDir="$srcDir/lib"
#- scripts ---------------------------------------------------------
scriptsDir="$srcDir/scripts"
appsDir="$scriptsDir/apps"
elemDir="$scriptsDir/elem"
#- sql -------------------------------------------------------------
sqlDir="$baseDir/sql"
if [[ ! -d $sqlDir ]]; then mkdir "$sqlDir"; fi
#- test ------------------------------------------------------------
testDir="$baseDir/test"
#-------------------------------------------------------------------
# CODE FILES
#-------------------------------------------------------------------
#crypter="$etcDir"/crypter.sh
#errors="$etcDir"/error.sh
yaml="$etcDir/yaml.sh"
common="$libDir/common.sh"
formats="$libDir/format.sh"
functions="$libDir/functions.sh"
logger="$libDir/log.sh"
register="$libDir/registry.sh"
#-------------------------------------------------------------------
# DATA FILES
#-------------------------------------------------------------------
DEF="$cfgDir/.defaults.yml"
NET="$cfgDir/.network.yml"
PRM="$cfgDir/.permissions.yml"
RMT="$cfgDir/.remote.yml"
REG="$registry/.registry"
PAS="$registry/.passwords"
SQL="$sqlDir/database.sql"
