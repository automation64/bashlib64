setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_cnt_setup || skip 'no container CLI found'
}

@test "_bl64_cnt_podman_run_interactive: parameters are not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run _bl64_cnt_podman_run_interactive
  assert_failure
}