setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_cnt_is_inside_container && skip 'not applicable to container mode'
  bl64_cnt_setup || skip 'no container CLI found'
  [[ -x "$BL64_CNT_CMD_PODMAN" ]] || skip 'podman not found'
}

@test "_bl64_cnt_podman_run_interactive: CLI runs ok" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run _bl64_cnt_podman_run_interactive "$BL64_CNT_SET_VERSION"
  assert_success
}
