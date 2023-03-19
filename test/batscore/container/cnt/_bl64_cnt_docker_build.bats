setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_cnt_setup || skip 'no container CLI found'
}

@@test "_bl64_cnt_docker_build: parameters are not present" {
  run _bl64_cnt_docker_build
  assert_failure
}