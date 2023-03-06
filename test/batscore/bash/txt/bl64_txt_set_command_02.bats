setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

}

@test "_bl64_txt_set_command: commands are set" {
  assert_not_equal "$BL64_TXT_CMD_AWK" ''
  assert_not_equal "$BL64_TXT_CMD_CUT" ''
  assert_not_equal "$BL64_TXT_CMD_ENVSUBST" ''
  assert_not_equal "$BL64_TXT_CMD_GREP" ''
  assert_not_equal "$BL64_TXT_CMD_SED" ''
  assert_not_equal "$BL64_TXT_CMD_TR" ''
  assert_not_equal "$BL64_TXT_CMD_BASE64" ''
}

@test "_bl64_txt_set_command: commands are present" {
  assert_file_executable "$BL64_TXT_CMD_AWK"
  assert_file_executable "$BL64_TXT_CMD_CUT"
  # assert_file_executable "$BL64_TXT_CMD_ENVSUBST"
  assert_file_executable "$BL64_TXT_CMD_GREP"
  assert_file_executable "$BL64_TXT_CMD_SED"
  assert_file_executable "$BL64_TXT_CMD_TR"
  assert_file_executable "$BL64_TXT_CMD_BASE64"

}
