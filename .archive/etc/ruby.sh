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
echo "Installing Ruby3 + Extensions ..."
log "spacer"
log "RUBY3 + EXTENSIONS"
log "line"
echo

apt_install ruby ruby-dev bundler rails

ruby -v
rails -v

echo
echo -e "${yellow}Ruby3 + Extensions${NC} Successfully Installed!"
