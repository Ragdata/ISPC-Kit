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
export HOST_REGEX='^[a-z0-9][a-z0-9\-]+\.[a-z0-9\.\-]+$'
export IPv4_REGEX='^((25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[0-9]?[0-9])\.?){4}$'
export IPv6_REGEX='^([a-fA-F0-9]{0,4}:?){6}([a-fA-F0-9]{1,4})$'
export isFlag="^\-.*"
export isLoc="^[a-z]{2}_[A-Z]{2}.*$"
export isPath="^(/[^/]*)*(/?.+(\..+))$"
export AFFIRM='^[Yy]$'
export NEGAT='^[Nn]$'
export RESP='^[YyNn]$'
# printable elements
export DEFAULT_Y="[${bold}Y${NC}/N]"
export DEFAULT_N="[Y/${bold}N${NC}]"
#-------------------------------------------------------------------
# PATHS
#-------------------------------------------------------------------
export rootDir=/root/.ispc
export logDir="$rootDir/logs"
if [[ ! -d $logDir ]]; then mkdir "$logDir"; fi

export registry="$baseDir/registry"
if [[ ! -h $registry ]]; then ln -s "$registry" "$rootDir"; fi

export cfgDir="$baseDir/cfg"
export nginxDir="$cfgDir/nginx"

export docsDir="$baseDir/docs"

export srcDir="$baseDir/src"
export scriptsDir="$srcDir/scripts"
export appsDir="$scriptsDir/apps"
export elemDir="$scriptsDir/elem"

export sqlDir="$baseDir/sql"
if [[ ! -d $sqlDir ]]; then mkdir "$sqlDir"; fi
#-------------------------------------------------------------------
# CODE FILES
#-------------------------------------------------------------------
#export crypter="$etcDir"/crypter.sh
#export errors="$etcDir"/error.sh
export yaml="$etcDir/yaml.sh"
export common="$incDir/common.sh"
export formats="$incDir/format.sh"
export functions="$incDir/functions.sh"
export register="$incDir/registry.sh"
#-------------------------------------------------------------------
# DATA FILES
#-------------------------------------------------------------------
export DEF="$cfgDir/.defaults.yml"
export PRM="$cfgDir/.permissions.yml"
export RMT="$cfgDir/.remote.yml"
export REG="$registry/.registry"
export PAS="$registry/.passwords"
export SQL="$sqlDir/database.sql"
