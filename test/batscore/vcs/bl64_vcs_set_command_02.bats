setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

}

@test "bl64_vcs_set_command: commands are set" {

  assert_not_equal "${BL64_VCS_CMD_GIT}" ''

}

@test "bl64_vcs_set_command: commands are present" {

  assert_file_executable "${BL64_VCS_CMD_GIT}"

}