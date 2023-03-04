setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_cnt_setup || skip 'no container CLI found'
}

@test "bl64_cnt_login_file: file parameter not existing" {
  run bl64_cnt_login_file '/xxx/yy/zzz/not_existing' 'test'
  assert_failure
}
