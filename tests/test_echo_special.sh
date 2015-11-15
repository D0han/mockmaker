#!/bin/bash

command="echo \"\"a\$PWD\\\'\""

source ./func.sh
check_outputs "$command"
exit $?
