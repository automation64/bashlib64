setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_cnt_is_inside_container && skip 'not applicable to container mode'
  bl64_cnt_setup || skip 'no container CLI found'
  [[ -x "$BL64_CNT_CMD_DOCKER" ]] || skip 'docker not found'
}

@test "bl64_cnt_run_docker: CLI runs ok" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_cnt_run_podman --version
  assert_success
}
