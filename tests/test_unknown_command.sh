#!/bin/bash

command="unknown_command"

./mockmaker ${command} > /dev/null 2>&1
if [ $? -ne 2 ]; then
    exit 1
fi
exit 0
