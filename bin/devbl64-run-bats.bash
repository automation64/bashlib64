#!/bin/bash

target=''
test_list=''

. ./.env || exit 1

cd "$DEVBL64_TEST" || exit 1

[[ -r "${DEVBL64_BUILD}/bashlib64.bash" ]] || exit 1

if [[ -n "$1" ]]; then
  test_list="./batscore/${1}.bats"
else
  test_list="$(echo ./batscore/*)"
fi

for target in $test_list; do
  echo "Test: $target"
  "$DEVBL64_CMD_BATS" --verbose-run "$target"
done
