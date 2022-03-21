setup() {
  . "$DEVBL_TEST_BASHLIB64"
  . "${DEVBL_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-file/load.bash"

  BATSLIB_TEMP_PRESERVE=0
  BATSLIB_TEMP_PRESERVE_ON_FAILURE=1

  TEST_SANDBOX="$(temp_make)"
}

@test "bl64_os_merge_dir: copy dir + file names with spaces + subdirs" {
  source="$DEVBL_SAMPLES/dir_04"
  target="$TEST_SANDBOX/target"
  mkdir "$target"
  set +u # to avoid IFS missing error in run function
  run bl64_os_merge_dir "$source" "$target"
  assert_success
  assert_dir_exist "${target}/dir with spaces/"
  assert_file_exist "${target}/dir with spaces/random_04_01.txt"
  assert_file_exist "${target}/file with spaces.txt"
}

teardown() {
  temp_del "$TEST_SANDBOX"
}
