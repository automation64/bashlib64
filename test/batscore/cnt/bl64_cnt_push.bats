setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_cnt_is_inside_container && skip 'not applicable to container mode'

  bl64_cnt_setup
}

@test "bl64_cnt_push: parameters are not present" {
  run bl64_cnt_push
  assert_failure
}

@test "bl64_cnt_push: 2nd parameter is not present" {
  run bl64_cnt_push '/dev/null'
  assert_failure
}