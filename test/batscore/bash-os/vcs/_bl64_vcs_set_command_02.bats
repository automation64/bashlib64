@test "_bl64_vcs_set_command: commands are set" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  assert_not_equal "${BL64_VCS_CMD_GIT}" ''

}

@test "_bl64_vcs_set_command: commands are present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  assert_file_executable "${BL64_VCS_CMD_GIT}"

}