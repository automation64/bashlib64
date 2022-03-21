setup() {
  . "$DEVBL_TEST_BASHLIB64"
  . "${DEVBL_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-file/load.bash"

  BATSLIB_TEMP_PRESERVE=0
  BATSLIB_TEMP_PRESERVE_ON_FAILURE=1

  TEST_SANDBOX="$(temp_make)"

  source="$DEVBL_SAMPLES/dir_01"
  target="$TEST_SANDBOX/target"
  mkdir "$target"
}

@test "bl64_os_merge_dir: missing source" {
  set +u # to avoid IFS missing error in run function
  run bl64_os_merge_dir
  assert_failure
}

@test "bl64_os_merge_dir: missing target" {
  set +u # to avoid IFS missing error in run function
  run bl64_os_merge_dir
  assert_failure "$source"
}

@test "bl64_os_merge_dir: missing source directory" {
  set +u # to avoid IFS missing error in run function
  run bl64_os_merge_dir
  assert_failure "/fake/dir" "$target"
}

@test "bl64_os_merge_dir: missing target directory" {
  set +u # to avoid IFS missing error in run function
  run bl64_os_merge_dir
  assert_failure "$source" "/fake/dir"
}

teardown() {
  temp_del "$TEST_SANDBOX"
}
