setup() {
  . "$DEVBL_TEST_SETUP"
}

@test "bl64_cnt_run_podman: CLI runs ok" {
  [[ ! -x "$BL64_CNT_CMD_PODMAN" ]] && skip

  run bl64_cnt_run_podman --version
  assert_success
}
