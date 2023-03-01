setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_cnt_setup || skip 'no container CLI found'
}

@test "bl64_cnt_podman_login: parameters are not present" {
  run bl64_cnt_podman_login
  assert_failure
}