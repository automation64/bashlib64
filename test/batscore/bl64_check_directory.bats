setup() {
  BL64_LIB_STRICT=0
  . "${DEVBL64_TEST}/lib/bashlib64.bash"
  . "${DEVBL64_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL64_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL64_BATS_HELPER}/bats-file/load.bash"

}

@test "bl64_check_directory: directory is present" {

  run bl64_check_directory '/etc'
  assert_success

}

@test "bl64_check_directory: directory is not present" {

  run bl64_check_directory '/fake/dir'
  assert_equal "$status" $BL64_CHECK_ERROR_DIRECTORY_NOT_FOUND && \
  [[ "$output" == *${_BL64_CHECK_TXT_DIRECTORY_NOT_FOUND}* ]]

}

@test "bl64_check_directory: directory parameter is not present" {

  run bl64_check_directory
  assert_equal "$status" $BL64_CHECK_ERROR_MISSING_PARAMETER && \
  [[ "$output" == *${_BL64_CHECK_TXT_MISSING_PARAMETER}* ]]

}
