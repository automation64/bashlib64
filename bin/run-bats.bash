#!/bin/bash

target=''
test_list=''

. ./.env || exit 1

cd "$PROJECT_BL64_TEST" || exit 1

if [[ -n "$1" ]]; then
  test_list="./batscore/${1}.bats"
else
  test_list="$(echo ./batscore/*)"
fi

for target in $test_list; do
  "$PROJECT_BL64_CMD_BATS" --verbose-run "$target"
done
