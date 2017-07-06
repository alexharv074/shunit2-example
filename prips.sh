#!/usr/bin/env bash

cidr=$1

usage() {
  [ ! -z "$1" ] && echo $1
  cat <<EOF
Print all IPs in a CIDR range, similar to the Ubuntu prips utility.
This script assumes that the Red Hat version of ipcalc is available.
Usage: $0 <cidr>
Example: $0 192.168.0.3/28
EOF
  exit 1
}
[ -h == "$cidr" ] && usage
[ -z "$cidr" ] && usage 'You must pass a CIDR'
echo $cidr | egrep -q "^(?:[0-9]+\.){3}[0-9]+/[0-9]+$" || \
  usage "$cidr is not a valid CIDR"

# range is bounded by network (-n) & broadcast (-b) addresses.
lo=$(ipcalc -n $cidr | cut -f2 -d=)
hi=$(ipcalc -b $cidr | cut -f2 -d=)

IFS=. read a b c d <<< "$lo"
IFS=. read e f g h <<< "$hi"

eval "echo {$a..$e}.{$b..$f}.{$c..$g}.{$d..$h}"
