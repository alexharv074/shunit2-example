#!/usr/bin/env bash

test_minus_h() {
  first_line=$(. ./prips.sh -h | head -1)
  assertEquals 'Print all IPs in a CIDR range, similar to the Ubuntu prips utility.' "$first_line"
}

. shunit2
