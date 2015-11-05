#!/bin/bash

command="unknown_command"

cd ..
./mock ${command} $> /dev/null
if [ $? -ne 1 ]; then
    exit 1
fi
exit 0
