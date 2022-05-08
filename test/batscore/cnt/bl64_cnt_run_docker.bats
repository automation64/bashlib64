setup() {
  . "$DEVBL_TEST_SETUP"
}

@test "bl64_cnt_run_docker: CLI runs ok" {
  [[ ! -x "$BL64_CNT_CMD_DOCKER" ]] && skip

  run bl64_cnt_run_podman --version
  assert_success
}
