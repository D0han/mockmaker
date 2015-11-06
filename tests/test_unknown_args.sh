#!/bin/bash

command="git version"
command_check="git aaaaaaaa"

outcome=0

cd ..
./mock ${command} > /dev/null 2>&1
cd mocks
./${command_check} > test_unknown_args_stdout.txt 2> test_unknown_args_stderr.txt
if [ $? -ne 1 ]; then
    >&2 echo "FAIL: Mock should fail with error code 1"
    let outcome+=1
fi

stdout=$(cat test_unknown_args_stdout.txt)
if [ -n "${stdout}" ]; then
    >&2 echo "FAIL: stdout is not empty"
    let outcome+=1
fi

stderr=$(cat test_unknown_args_stderr.txt)
if [ -z "${stderr}" ]; then
    >&2 echo "FAIL: stderr is empty"
    let outcome+=1
fi

rm test_unknown_args_stdout.txt test_unknown_args_stderr.txt

exit $outcome
