setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_vcs_run_git: CLI runs ok" {
  [[ ! -x "$BL64_VCS_CMD_GIT" ]] && skip 'git not found'

  run bl64_vcs_run_git --version
  assert_success
}
