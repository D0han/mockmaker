#!/bin/bash

cd ..
shellcheck -x ./mockmaker
exitcode=$?
cd "$OLDPWD" || exit 64
exit $exitcode
