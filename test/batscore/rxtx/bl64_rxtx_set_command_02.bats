setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

}

@test "bl64_rxtx_set_command: commands are set" {

  assert_not_equal "${BL64_RXTX_CMD_CURL}" ''
  assert_not_equal "${BL64_RXTX_CMD_WGET}" ''

}

@test "bl64_rxtx_set_command: commands are present" {

  assert_file_executable "${BL64_RXTX_CMD_CURL}"
  assert_file_executable "${BL64_RXTX_CMD_WGET}"

}
