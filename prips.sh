#!/usr/bin/env bash

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
[ -h == "$1" ] && usage
[ -z $1 ] && usage 'You must pass a CIDR'

cidr=$1

# range is bounded by network (-n) & broadcast (-b) addresses.
lo=$(ipcalc -n $cidr | cut -f2 -d=)
hi=$(ipcalc -b $cidr | cut -f2 -d=)

read a b c d <<< $(echo $lo | tr . ' ')
read e f g h <<< $(echo $hi | tr . ' ')

eval "echo {$a..$e}.{$b..$f}.{$c..$g}.{$d..$h}"
