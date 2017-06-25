#!/usr/bin/env bash

test_minus_h() {
  first_line=$(. ./prips.sh -h | head -1)
  assertEquals 'Print all IPs in a CIDR range, similar to the Ubuntu prips utility.' "$first_line"
}

test_missing_args() {
  first_line=$(. ./prips.sh | head -1)
  assertEquals 'You must pass a CIDR' "$first_line"
}

. shunit2
