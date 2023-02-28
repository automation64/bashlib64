setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_cnt_is_inside_container && skip 'not applicable to container mode'

  bl64_cnt_setup
}

@test "bl64_cnt_pull: parameters are not present" {
  run bl64_cnt_pull
  assert_failure
}