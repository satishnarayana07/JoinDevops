#!/bin/bash

start_time=$(date +%s)
echo "$start_time"

sleep 10

end_time=$(date +%s)

echo "$end_time"

total_time=$((end_time - start_time))
echo "total time taken to execute the script: $total_time seconds"