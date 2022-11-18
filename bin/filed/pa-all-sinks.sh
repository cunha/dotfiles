#!/bin/sh
set -eu
set -x

cmd=$1
shift

for sink in $(pacmd list-sinks | grep 'index:' | cut -b 12-) ; do
  pactl $cmd $sink $*
done
