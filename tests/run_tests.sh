#!/bin/bash

run_tests () {
    outcome_tmp=0

    for f in "$@"; do
        echo "Running ${f} test suite"
        if ! "./$f"; then
            echo "ERROR: Test failed: ${f}" >&2
            (( outcome_tmp++ ))
        fi
        echo ""
    done
    return $outcome_tmp
}

outcome=0

rm -rf ./mocks
run_tests test_*.sh
(( outcome += $? ))

if [ "$1" != "--skip-shellcheck" ]; then
    run_tests shellcheck_test_*.sh
    (( outcome += $? ))
    echo "You can skip shellcheck tests with --skip-shellcheck"
else
    echo "Skipping shellcheck..."
fi

exit $outcome
