setup() {
  . "$DEVBL_TEST_BASHLIB64"
  . "${DEVBL_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-file/load.bash"
  set +u # to avoid IFS missing error in run function
}

@test "bl64_check_directory: directory is present" {

  run bl64_check_directory '/etc'
  assert_success

}

@test "bl64_check_directory: directory is not present" {

  run bl64_check_directory '/fake/dir'
  assert_failure
  assert_equal "$status" $BL64_CHECK_ERROR_DIRECTORY_NOT_FOUND

}

@test "bl64_check_directory: directory parameter is not present" {

  run bl64_check_directory
  assert_failure

}
