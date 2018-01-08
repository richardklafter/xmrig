#!/bin/bash
if [ "$#" -ne 1 ]; then
  echo "usage: ./run.sh NUMBER_OF_THREADS"
  exit 1
fi
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$DIR"
echo "Detected $NUMCPU cores running with $NUMTHREADS threads"
exec ../build/xmrig -t "$1" -o stratum+tcp://xdn-xmr.pool.minergate.com:45560 -u rpklafter@yahoo.com -p x

