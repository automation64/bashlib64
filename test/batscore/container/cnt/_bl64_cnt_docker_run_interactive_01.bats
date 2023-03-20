setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_cnt_setup || skip 'no container CLI found'
}

@test "_bl64_cnt_docker_run_interactive: parameters are not present" {
  run _bl64_cnt_docker_run_interactive
  assert_failure
}