#!/bin/bash
#-------------------------------------------------------------------
# src/etc/yaml.sh
#-------------------------------------------------------------------
# YAML Parsing Utility
#
# File:         yaml.sh
# Author:       Ragdata
# Date:         26/02/2021 1353
# License:      MIT License
# Copyright:    Copyright (c) 2017 Jonathan Peres
# Attribution:  From the jasperes/bash-yaml project on GitHub
#-------------------------------------------------------------------
# INIT
#-------------------------------------------------------------------
#indent=4
#
#parse_yaml() {
#    local yaml_file=$1
#    local prefix=$2
#    local s
#    local w
#    local fs
#
#    s='[[:space:]]*'
#    w='[a-zA-Z0-9_.-]*'
#    fs="$(echo @|tr @ '\034')"
#
#    (
#        sed -e '/- [^\“]'"[^\']"'.*: /s|\([ ]*\)- \([[:space:]]*\)|\1-\'$'\n''  \1\2|g' |
#
#        sed -ne '/^--/s|--||g; s|\"|\\\"|g; s/[[:space:]]*$//g;' \
#            -e 's/\$/\\\$/g' \
#            -e "/#.*[\"\']/!s| #.*||g; /^#/s|#.*||g;" \
#            -e "s|^\($s\)\($w\)$s:$s\"\(.*\)\"$s\$|\1$fs\2$fs\3|p" \
#            -e "s|^\($s\)\($w\)${s}[:-]$s\(.*\)$s\$|\1$fs\2$fs\3|p" |
#
#        awk -F"$fs" '{
#            indent = length($1)/2;
#            if (length($2) == 0) { conj[indent]="+";} else {conj[indent]="";}
#            vname[indent] = $2;
#            for (i in vname) {if (i > indent) {delete vname[i]}}
#                if (length($3) > 0) {
#                    vn=""; for (i=0; i<indent; i++) {vn=(vn)(vname[i])("_")}
#                    printf("%s%s%s%s=(\"%s\")\n", "'"$prefix"'",vn, $2, conj[indent-1], $3);
#                }
#            }' |
#
#        sed -e 's/_=/+=/g' |
#
#        awk 'BEGIN {
#                FS="=";
#                OFS="="
#            }
#            /(-|\.).*=/ {
#                gsub("-|\\.", "_", $1)
#            }
#            { print }'
#    ) < "$yaml_file"
#}

parse_yaml()
{
   local prefix=$2
   local s='[[:space:]]*' w='[a-zA-Z0-9_]*' fs=$(echo @|tr @ '\034')
   sed -ne "s|^\($s\)\($w\)$s:$s\"\(.*\)\"$s\$|\1$fs\2$fs\3|p" \
        -e "s|^\($s\)\($w\)$s:$s\(.*\)$s\$|\1$fs\2$fs\3|p"  "$1" |
   awk -F"$fs" '{
      indent = length($1)/2;
      vname[indent] = $2;
      for (i in vname) {if (i > indent) {delete vname[i]}}
      if (length($3) > 0) {
         vn=""; for (i=0; i<indent; i++) {vn=(vn)(vname[i])("_")}
         printf("%s%s%s=\"%s\"\n", "'$prefix'",vn, $2, $3);
      }
   }'
}
unset_variables() {
  # Pulls out the variable names and unsets them.
  local variable_string="$@"
  unset variables
  variables=()
  for variable in "${variable_string[@]}"
  do
    variables+=($(echo "$variable" | grep '=' | sed 's/=.*//' | sed 's/+.*//'))
  done
  for variable in "${variables[@]}"
  do
    unset "$variable"
  done
}

create_variables() {
    local yaml_file=${1:-""}
    local prefix=${2:-""}
    local yaml_string="$(parse_yaml "$yaml_file" "$prefix")"
    unset_variables "${yaml_string[@]}"
    eval "${yaml_string}"
}
