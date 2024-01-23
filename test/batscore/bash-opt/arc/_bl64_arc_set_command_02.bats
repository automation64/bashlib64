setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "_bl64_arc_set_command: commands are set" {
  bl64_arc_setup
  assert_not_equal "${BL64_ARC_CMD_TAR}" ''
  assert_not_equal "${BL64_ARC_CMD_UNZIP}" ''
}

@test "_bl64_arc_set_command: commands are present" {
  bl64_arc_setup
  assert_file_executable "${BL64_ARC_CMD_TAR}"
  assert_file_executable "${BL64_ARC_CMD_UNZIP}"
}
