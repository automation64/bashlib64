setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_cnt_setup || skip 'no container CLI found'
}

@test "bl64_cnt_login: parameters are not present" {
  run bl64_cnt_login
  assert_failure
}

@test "bl64_cnt_login: 2nd parameter is not present" {
  run bl64_cnt_login '/dev/null'
  assert_failure
}

@test "bl64_cnt_login: 3nd parameter is not present" {
  run bl64_cnt_login '/dev/null' 'test'
  assert_failure
}