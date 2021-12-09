#!/bin/sh

. ../.env
target=''
test_list=''

if test -n "$1"; then
  test_list="./batscore/${1}.bats"
else
  test_list="$(echo ./batscore/*)"
fi

for target in $test_list; do
  "$PROJECT_BL64_CMD_BATS" --verbose-run "$target"
done
