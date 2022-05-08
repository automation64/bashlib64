setup() {
  . "$DEVBL_TEST_SETUP"
}

@test "bl64_vcs_run_git: CLI runs ok" {
  [[ ! -x "$BL64_VCS_CMD_GIT" ]] && skip

  run bl64_vcs_run_git --version
  assert_success
}
