#-------------------------------------------------------------------
# src/etc/ruby.sh
#-------------------------------------------------------------------
# ISPC Kit - ISPConfig 3 Installer
#
# File:         ruby.sh
# Author:       Ragdata
# Date:         23/02/2021 1446
# License:      MIT License
# Copyright:    2021 ~ Aequitas Veritas Pty Ltd ~ All Rights Reserved
#-------------------------------------------------------------------
# MAIN
#-------------------------------------------------------------------
echoLog "Installing Ruby3 + Extensions"
echoLog "spacer"

apt_install ruby ruby-dev bundler rails

ruby -v
rails -v

echo
echo -e "${BR3}Ruby3 + Extensions${_A} Successfully Installed!"
