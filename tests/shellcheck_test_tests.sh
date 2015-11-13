#!/bin/bash

shellcheck ./*.sh
if [ $? -ne 0 ]; then
    exit 1
fi

