setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_arc_setup
}

@test "_bl64_arc_set_command: commands are set" {

  assert_not_equal "${BL64_ARC_CMD_TAR}" ''
  assert_not_equal "${BL64_ARC_CMD_UNZIP}" ''

}

@test "_bl64_arc_set_command: commands are present" {

  assert_file_executable "${BL64_ARC_CMD_TAR}"
  assert_file_executable "${BL64_ARC_CMD_UNZIP}"

}
