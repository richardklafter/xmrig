#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$DIR"
echo "Sleeping 60s to collect current load average..."
sleep 61
CURRENT_LOAD_AVG=$(cat /proc/loadavg | awk '{print $1}') #load avg of last 1 min
NUMBER_CPUS=$(grep -c ^processor /proc/cpuinfo)
NUMBER_CPUS_FREE=${2:-1} #by default we use one always leave one core free as breathing room. This can be overridden via $2
NUMBER_OF_THREADS=$(python -c "from math import floor; print(max(int(floor($NUMBER_CPUS-$CURRENT_LOAD_AVG-$NUMBER_CPUS_FREE)),1))")
LOAD_LIMIT=$(python -c "print($NUMBER_CPUS-1.0)")
echo "Detected current load of $CURRENT_LOAD_AVG and $NUMBER_CPUS cpus. Running $NUMBER_OF_THREADS threads with load limit of $LOAD_LIMIT"

#Shutdown the miner in $1 seconds
SHUTDOWN_SECONDS="$1"
if [ -n "${SHUTDOWN_SECONDS}" ]; then
  echo "Shutting down the miner in ${SHUTDOWN_SECONDS} seconds"
  ( sleep $SHUTDOWN_SECONDS; echo "Shutting down miner after ${SHUTDOWN_SECONDS} seconds"; kill $$ ) &
fi
exec cputool -v --load-limit "$LOAD_LIMIT" ./run.sh "$NUMBER_OF_THREADS"

