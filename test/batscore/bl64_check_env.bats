setup() {
  . "${DEVBL64_TEST}/lib/bashlib64.bash"
  . "${DEVBL64_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL64_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL64_BATS_HELPER}/bats-file/load.bash"

}

@test "bl64_check_env: public constants are set" {

  assert_equal $BL64_CHECK_ERROR_MISSING_PARAMETER 1 ]] && \
  assert_equal $BL64_CHECK_ERROR_FILE_NOT_FOUND 2 ]] && \
  assert_equal $BL64_CHECK_ERROR_FILE_NOT_READ 3 ]] && \
  assert_equal $BL64_CHECK_ERROR_FILE_NOT_EXECUTE 4 ]]

}