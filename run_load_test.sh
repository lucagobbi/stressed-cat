#!/bin/bash

source config.sh

mkdir -p "$RESULTS_DIR"

run_test() {
    local users=$1
    local timestamp=$(date +"%Y%m%d_%H%M%S")
    local result_dir="${RESULTS_DIR}/${users}_users_${timestamp}"
    mkdir -p "$result_dir"

    echo "Starting main test for $users users"
    locust -f "$LOCUST_FILE" --headless -u $users -r $((users/10)) -t "${TEST_DURATION}" \
        --html "$result_dir/report.html" \
        --csv "$result_dir/report" 

    echo "Test completed for $users users. Results saved in $result_dir"
}

cleanup() {
    # Should clean up or restart docker container here
    echo "Performing cleanup..."
}

for users in "${USER_COUNTS[@]}"
do
    echo "Starting iteration for $users users"
    run_test $users

    if [ "$users" != "${USER_COUNTS[-1]}" ]; then
        echo "Pausing for $PAUSE_TIME seconds to allow return to idle state"
        sleep $PAUSE_TIME
    fi

    cleanup
done

echo "All tests completed."
