setup() {
  . "$DEVBL_TEST_BASHLIB64"
  . "${DEVBL_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-file/load.bash"

}

@test "bl64_os_set_command: commands are set" {

  assert_not_equal "${BL64_OS_CMD_AWK}" ''
  assert_not_equal "${BL64_OS_CMD_CAT}" ''
  assert_not_equal "${BL64_OS_CMD_CHMOD}" ''
  assert_not_equal "${BL64_OS_CMD_CHOWN}" ''
  assert_not_equal "${BL64_OS_CMD_CP}" ''
  assert_not_equal "${BL64_OS_CMD_DATE}" ''
  assert_not_equal "${BL64_OS_CMD_GAWK}" ''
  assert_not_equal "${BL64_OS_CMD_GREP}" ''
  assert_not_equal "${BL64_OS_CMD_HOSTNAME}" ''
  assert_not_equal "${BL64_OS_CMD_ID}" ''
  assert_not_equal "${BL64_OS_CMD_LN}" ''
  assert_not_equal "${BL64_OS_CMD_LS}" ''
  assert_not_equal "${BL64_OS_CMD_MKDIR}" ''
  assert_not_equal "${BL64_OS_CMD_MKTEMP}" ''
  assert_not_equal "${BL64_OS_CMD_MV}" ''
  assert_not_equal "${BL64_OS_CMD_RM}" ''
  assert_not_equal "${BL64_OS_CMD_TAR}" ''

}

@test "bl64_os_set_command: commands are present" {

  assert_file_executable "${BL64_OS_CMD_AWK}"
  assert_file_executable "${BL64_OS_CMD_CAT}"
  assert_file_executable "${BL64_OS_CMD_CHMOD}"
  assert_file_executable "${BL64_OS_CMD_CHOWN}"
  assert_file_executable "${BL64_OS_CMD_CP}"
  assert_file_executable "${BL64_OS_CMD_DATE}"
  assert_file_executable "${BL64_OS_CMD_GAWK}"
  assert_file_executable "${BL64_OS_CMD_GREP}"
  assert_file_executable "${BL64_OS_CMD_HOSTNAME}"
  assert_file_executable "${BL64_OS_CMD_ID}"
  assert_file_executable "${BL64_OS_CMD_LN}"
  assert_file_executable "${BL64_OS_CMD_LS}"
  assert_file_executable "${BL64_OS_CMD_MKDIR}"
  assert_file_executable "${BL64_OS_CMD_MKTEMP}"
  assert_file_executable "${BL64_OS_CMD_MV}"
  assert_file_executable "${BL64_OS_CMD_RM}"
  assert_file_executable "${BL64_OS_CMD_TAR}"

}
