#!/bin/bash
CURRENT_LOAD_AVG=$(cat /proc/loadavg | awk '{print $3}') #load avg of last 10 mins
NUMBER_CPUS=$(grep -c ^processor /proc/cpuinfo)
NUMBER_OF_THREADS=$(python -c "from math import floor; print(int(floor($NUMBER_CPUS-$CURRENT_LOAD_AVG-1)))")
LOAD_LIMIT=$(python -c "print($NUMBER_CPUS-1.0)")
echo "Detected current load of $CURRENT_LOAD_AVG and $NUMBER_CPUS cpus. Running $NUMBER_OF_THREADS threads with load limit of $LOAD_LIMIT"
exec cputool -v --load-limit "$LOAD_LIMIT" ./run.sh "$NUMBER_OF_THREADS"

