setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_cnt_setup || skip 'no container CLI found'
}

@test "bl64_cnt_login_stdin: parameters are not present" {
  run bl64_cnt_login_stdin
  assert_failure
}

@test "bl64_cnt_login_stdin: 2nd parameter is not present" {
  run bl64_cnt_login_stdin '/dev/null'
  assert_failure
}
