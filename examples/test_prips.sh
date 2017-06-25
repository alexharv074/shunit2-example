#!/usr/bin/env bash

# Fake the output of the ipcalc.
ipcalc() {
  case "$*" in
  "-n 192.168.0.2/28")
    echo NETWORK=192.168.0.0
    ;;
  "-b 192.168.0.2/28")
    echo BROADCAST=192.168.0.15
    ;;
  "-n 10.45.0.0/16")
    echo NETWORK=10.45.0.0
    ;;
  "-b 10.45.0.0/16")
    echo BROADCAST=10.45.255.255
  esac
}

test_minus_h() {
  first_line=$(. ./prips.sh -h | head -1)
  assertEquals 'Print all IPs in a CIDR range, similar to the Ubuntu prips utility.' "$first_line"
}

test_missing_args() {
  first_line=$(. ./prips.sh | head -1)
  assertEquals 'You must pass a CIDR' "$first_line"
}

test_a_little_cidr() {
  response=$(. ./prips.sh 192.168.0.2/28)
  expected="192.168.0.0 192.168.0.1 192.168.0.2 192.168.0.3 192.168.0.4 \
192.168.0.5 192.168.0.6 192.168.0.7 192.168.0.8 192.168.0.9 192.168.0.10 \
192.168.0.11 192.168.0.12 192.168.0.13 192.168.0.14 192.168.0.15"
  assertEquals "$expected" "$response"
}

test_a_big_cidr() {
  number_of_ips=$(. ./prips.sh 10.45.0.0/16 | wc -w)
  expected=65536
  assertEquals $expected $number_of_ips
}

. shunit2
