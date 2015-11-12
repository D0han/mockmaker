#!/bin/bash

run_tests () {
    outcome_tmp=0

    # shellcheck disable=SC2048
    for f in $*; do
        echo "Running ${f} test suite"
        "./${f}"
        if [ $? -ne 0 ]; then
            echo "ERROR: Test failed: ${f}" >&2
            let outcome_tmp+=1
        fi
        echo ""
    done
    return $outcome_tmp
}

outcome=0

run_tests "test_*.sh"
let outcome+=$?

if [ "$1" != "--skip-shellcheck" ]; then
    run_tests "shellcheck_test_*.sh"
    let outcome+=$?
    echo "Ypu can skip shellcheck tests with --skip-shellcheck"
else
    echo "Skipping shellcheck..."
fi

exit $outcome
