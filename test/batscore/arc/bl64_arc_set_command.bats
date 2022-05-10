setup() {
  . "$DEVBL_TEST_SETUP"

}

@test "bl64_arc_set_command: commands are set" {

  assert_not_equal "${BL64_ARC_CMD_TAR}" ''
  assert_not_equal "${BL64_ARC_CMD_UNZIP}" ''

}

@test "bl64_arc_set_command: commands are present" {

  assert_file_executable "${BL64_ARC_CMD_TAR}"
  assert_file_executable "${BL64_ARC_CMD_UNZIP}"

}
