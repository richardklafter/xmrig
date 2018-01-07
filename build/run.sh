#!/bin/bash
NUMCPU=$(grep -c ^processor /proc/cpuinfo)
NUMTHREADS=$(python -c "from math import floor; print int(floor($NUMCPU*.60))")
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$DIR"
echo "Detected $NUMCPU cores running with $NUMTHREADS threads"
exec ./xmrig -t "$NUMTHREADS" -o stratum+tcp://xdn-xmr.pool.minergate.com:45560 -u rpklafter@yahoo.com -p x

