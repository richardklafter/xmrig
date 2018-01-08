#!/bin/bash
NUMCPU=$(grep -c ^processor /proc/cpuinfo)
CPULIMIT=$(python -c "print($NUMCPU*.90)")
echo "Detected $NUMCPU cores running with load limit of $CPULIMIT"
exec cputool -v --load-limit "$CPULIMIT" ./run.sh

