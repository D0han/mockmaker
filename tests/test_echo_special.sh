#!/bin/bash

command='echo "\"a\$PWD\\"'
commmand="${command}\'"

source ./func.sh
check_outputs "$command"
exit $?
