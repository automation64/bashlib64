setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_cnt_setup || skip 'no container CLI found'
  [[ ! -x "$BL64_CNT_CMD_PODMAN" ]] && skip 'podman not found'
}

@test "bl64_cnt_docker_run_interactive: CLI runs ok" {
  run bl64_cnt_docker_run_interactive --version
  assert_success
}

@test "bl64_cnt_docker_run_interactive: parameters are not present" {
  run bl64_cnt_docker_run_interactive
  assert_failure
}