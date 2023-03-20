setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_cnt_setup || skip 'no container CLI found'
}

@test "_bl64_cnt_podman_tag: parameters are not present" {
  run _bl64_cnt_podman_tag
  assert_failure
}