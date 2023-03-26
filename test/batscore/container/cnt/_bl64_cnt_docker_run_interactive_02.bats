setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_cnt_setup || skip 'no container CLI found'
  [[ -x "$BL64_CNT_CMD_DOCKER" && -f "$BL64_CNT_PATH_DOCKER_SOCKET" ]] || skip 'docker not found'
}

@test "_bl64_cnt_docker_run_interactive: CLI runs ok" {
  run _bl64_cnt_docker_run_interactive "$BL64_CNT_SET_VERSION"
  assert_success
}
