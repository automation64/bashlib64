setup() {
  . "$DEVBL_TEST_BASHLIB64"
  . "${DEVBL_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-file/load.bash"

  BATSLIB_TEMP_PRESERVE=0
  BATSLIB_TEMP_PRESERVE_ON_FAILURE=1

  TEST_SANDBOX="$(temp_make)"
  TEST_SOURCE="$DEVBL_SAMPLES"
  TEST_FILE='text_01.txt'
}

@test "bl64_fs_cp_file: copy file" {
  set +u # to avoid IFS missing error in run function
  run bl64_fs_cp_file "${TEST_SOURCE}/${TEST_FILE}" "$TEST_SANDBOX"
  assert_success
  assert_file_exist "${TEST_SANDBOX}/${TEST_FILE}"
}

teardown() {
  temp_del "$TEST_SANDBOX"
}
