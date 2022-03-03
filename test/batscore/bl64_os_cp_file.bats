setup() {
  . "$DEVBL_TEST_BASHLIB64"
  . "${DEVBL_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-file/load.bash"

  BATSLIB_TEMP_PRESERVE=0
  BATSLIB_TEMP_PRESERVE_ON_FAILURE=1

  TEST_SANDBOX="$(temp_make)"
  TEST_SOURCE='/etc'
  TEST_FILE='group'
}

@test "bl64_os_cp_file: copy file" {
  set +u # to avoid IFS missing error in run function
  run bl64_os_cp_file "${TEST_SOURCE}/${TEST_FILE}" "$TEST_SANDBOX"
  assert_equal "$status" '0'
  assert_file_exist "${TEST_SANDBOX}/${TEST_FILE}"
}

teardown() {
  temp_del "$TEST_SANDBOX"
}
