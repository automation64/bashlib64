setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_cnt_setup || skip 'no container CLI found'
  [[ -x "$BL64_CNT_CMD_PODMAN" ]] || skip 'podman not found'
}

@test "bl64_cnt_run_podman: CLI runs ok" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_cnt_run_podman --version
  assert_success
}
