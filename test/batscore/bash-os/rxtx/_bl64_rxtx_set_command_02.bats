@test "_bl64_rxtx_set_command: commands are set" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  assert_not_equal "${BL64_RXTX_CMD_CURL}" ''
  assert_not_equal "${BL64_RXTX_CMD_WGET}" ''

}

@test "_bl64_rxtx_set_command: commands are present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  assert_file_executable "${BL64_RXTX_CMD_CURL}"
  assert_file_executable "${BL64_RXTX_CMD_WGET}"

}
