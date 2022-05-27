setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

}

@test "bl64_os_set_command: commands are set" {

  assert_not_equal "${BL64_OS_CMD_CAT}" ''
  assert_not_equal "${BL64_OS_CMD_DATE}" ''
  assert_not_equal "${BL64_OS_CMD_FALSE}" ''
  assert_not_equal "${BL64_OS_CMD_HOSTNAME}" ''
  assert_not_equal "${BL64_OS_CMD_ID}" ''
  assert_not_equal "${BL64_FS_CMD_RM}" ''
  assert_not_equal "${BL64_OS_CMD_TRUE}" ''
  assert_not_equal "${BL64_OS_CMD_UNAME}" ''
  assert_not_equal "${BL64_OS_CMD_BASH}" ''

}

@test "bl64_os_set_command: commands are present" {

  assert_file_executable "${BL64_OS_CMD_CAT}"
  assert_file_executable "${BL64_OS_CMD_DATE}"
  assert_file_executable "${BL64_OS_CMD_FALSE}"
  assert_file_executable "${BL64_OS_CMD_HOSTNAME}"
  assert_file_executable "${BL64_OS_CMD_ID}"
  assert_file_executable "${BL64_FS_CMD_RM}"
  assert_file_executable "${BL64_OS_CMD_TRUE}"
  assert_file_executable "${BL64_OS_CMD_UNAME}"
  assert_file_executable "${BL64_OS_CMD_BASH}"

}
