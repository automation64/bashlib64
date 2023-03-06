setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_cnt_setup || skip 'no container CLI found'
  [[ -x "$BL64_CNT_CMD_PODMAN" ]] || skip 'podman not found'
}

@test "bl64_cnt_podman_run_interactive: CLI runs ok" {
  run bl64_cnt_podman_run_interactive "$BL64_CNT_SET_PODMAN_VERSION"
  assert_success
}
