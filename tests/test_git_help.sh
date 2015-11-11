#!/bin/bash

command="git --help"

source ./func.sh
check_outputs "$command"
exit $?
