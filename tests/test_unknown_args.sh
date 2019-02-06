#!/bin/bash

command=( "git" "version" )
command_check=( "git" "aaaaaaaa" )

outcome=0

./mockmaker "${command[@]}" > /dev/null 2>&1
cd mocks || exit 1
# shellcheck disable=SC2145
./"${command_check[@]}" > test_unknown_args_stdout.txt 2> test_unknown_args_stderr.txt
if [ $? -ne 1 ]; then
    >&2 echo "FAIL: Mock should fail with error code 1"
    (( outcome++ ))
fi

stdout=$(cat test_unknown_args_stdout.txt)
if [ -n "${stdout}" ]; then
    >&2 echo "FAIL: stdout is not empty"
    (( outcome++ ))
fi

stderr=$(cat test_unknown_args_stderr.txt)
if [ -z "${stderr}" ]; then
    >&2 echo "FAIL: stderr is empty"
    (( outcome++ ))
fi

rm test_unknown_args_stdout.txt test_unknown_args_stderr.txt

exit $outcome
