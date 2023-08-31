setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_cnt_is_inside_container && skip 'not applicable to container mode'
}

@test "bl64_cnt_setup: module setup" {
  run bl64_cnt_setup
  assert_success
}
