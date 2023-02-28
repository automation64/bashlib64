setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_cnt_is_inside_container && skip 'not applicable to container mode'
  bl64_cnt_setup
}

@test "bl64_cnt_login_file: parameters are not present" {
  run bl64_cnt_login_file
  assert_failure
}

@test "bl64_cnt_login_file: 2nd parameter is not present" {
  run bl64_cnt_login_file '/dev/null'
  assert_failure
}

@test "bl64_cnt_login_file: 3nd parameter is not present" {
  run bl64_cnt_login_file '/dev/null' 'test'
  assert_failure
}