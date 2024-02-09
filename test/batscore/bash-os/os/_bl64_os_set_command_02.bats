@test "_bl64_os_set_command: commands are set" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  assert_not_equal "${BL64_OS_CMD_BASH}" ''
  assert_not_equal "${BL64_OS_CMD_CAT}" ''
  assert_not_equal "${BL64_OS_CMD_DATE}" ''
  assert_not_equal "${BL64_OS_CMD_FALSE}" ''
  assert_not_equal "${BL64_OS_CMD_HOSTNAME}" ''
  assert_not_equal "${BL64_OS_CMD_LOCALE}" ''
  assert_not_equal "${BL64_OS_CMD_TEE}" ''
  assert_not_equal "${BL64_OS_CMD_TRUE}" ''
  assert_not_equal "${BL64_OS_CMD_UNAME}" ''
}

@test "_bl64_os_set_command: commands are present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  assert_file_executable "${BL64_OS_CMD_BASH}"
  assert_file_executable "${BL64_OS_CMD_CAT}"
  assert_file_executable "${BL64_OS_CMD_DATE}"
  assert_file_executable "${BL64_OS_CMD_FALSE}"
  assert_file_executable "${BL64_OS_CMD_HOSTNAME}"
  # assert_file_executable "${BL64_OS_CMD_LOCALE}" # do not enable, not present in all os
  assert_file_executable "${BL64_OS_CMD_TEE}"
  assert_file_executable "${BL64_OS_CMD_TRUE}"
  assert_file_executable "${BL64_OS_CMD_UNAME}"
}
