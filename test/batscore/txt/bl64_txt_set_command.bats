setup() {
  . "$DEVBL_TEST_SETUP"

}

@test "bl64_txt_set_command: commands are set" {

  assert_not_equal "${BL64_TXT_CMD_AWK}" ''
  assert_not_equal "${BL64_TXT_CMD_GREP}" ''

}

@test "bl64_txt_set_command: commands are present" {

  assert_file_executable "${BL64_TXT_CMD_AWK}"
  assert_file_executable "${BL64_TXT_CMD_GREP}"

}
