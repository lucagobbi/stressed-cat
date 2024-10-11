# Cheshire Cat Load Testing

This project contains scripts and configuration for load testing the Cheshire Cat API using Locust.

## Overview

The load testing suite is designed to simulate various levels of user traffic to the Cheshire Cat API, allowing for performance analysis and bottleneck identification. It uses Locust, a popular open-source load testing tool, to generate traffic and collect metrics.

## Files

- `run_load_test.sh`: Main script to execute the load tests
- `config.sh`: Configuration file for test parameters
- `locustfile.py`: Locust test scenarios definition

## Prerequisites

- Bash shell
- Python 3.7+
- Locust (`pip install -r requirements.txt`)
- Docker (for running the Cheshire Cat API)

## Configuration

Edit `config.sh` to modify the following parameters:

- `LOCUST_FILE`: Path to the Locust file (default: "locustfile.py")
- `RESULTS_DIR`: Directory to store test results (default: "results")
- `USER_COUNTS`: Array of user counts for each test iteration (default: 10, 50, 100, 500)
- `TEST_DURATION`: Duration of each test run (default: "3m")
- `PAUSE_TIME`: Pause time between test iterations in seconds (default: 60)

## Usage

1. Ensure the Cheshire Cat API is running (defaults on `http://localhost:1865`)
2. Run the load test script:

   ```
   ./run_load_test.sh
   ```

3. The script will execute multiple test iterations based on the `USER_COUNTS` defined in `config.sh`
4. Results for each iteration will be saved in the `RESULTS_DIR` with timestamps

## Test Scenarios

The `locustfile.py` defines two main tasks:

1. `get_status`: Simulates checking the API status (weight: 1)
2. `send_message`: Simulates sending a message to the Cheshire Cat using the HTTP message endpoint (weight: 2)

## Results

After each test iteration, you'll find the following in the results directory:

- HTML report (`report.html`)
- CSV files with detailed metrics

The current load tests are configured to run against a Cheshire Cat instance with the following resource constraints:

```yaml
deploy:
  resources:
    limits:
      cpus: '2'
      memory: 4G
    reservations:
      cpus: '2'
      memory: 4G
```

## Customization

To add or modify test scenarios, edit the `locustfile.py` file. Refer to the [Locust documentation](https://docs.locust.io/) for more information on creating custom user behaviors and tasks.
