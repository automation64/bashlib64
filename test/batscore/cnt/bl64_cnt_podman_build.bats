setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_cnt_setup || skip 'no container CLI found'
}

@@test "bl64_cnt_podman_build: parameters are not present" {
  run bl64_cnt_podman_build
  assert_failure
}