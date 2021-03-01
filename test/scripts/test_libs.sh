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
baseDir=$(dirname "${BASH_SOURCE[0]}")
#-------------------------------------------------------------------
# LOAD LIBRARIES
#-------------------------------------------------------------------
. "$baseDir/src/lib/common.sh" || return 1
. "$formats" || return 1
. "$functions" || return 1
. "$logger" || return 1
. "$register" || return 1
. "$yaml" || return 1
# and it really is that simple - as long as the libraries are loading with
# no problems, that's all I need this test to do!
return 0
