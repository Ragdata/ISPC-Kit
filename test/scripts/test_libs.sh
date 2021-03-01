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
baseDir="./../.."
#-------------------------------------------------------------------
# LOAD LIBRARIES
#-------------------------------------------------------------------
. "$baseDir/src/lib/common.sh" || exit 1
. "$formats" || exit 1
. "$functions" || exit 1
. "$logger" || exit 1
. "$register" || exit 1
. "$yaml" || exit 1
# and it really is that simple - as long as the libraries are loading with
# no problems, that's all I need this test to do!
exit 0
