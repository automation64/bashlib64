@test "bl64_txt_replace_env: file parameter not existing" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_txt_replace_env '/xxx/yy/zzz/not_existing' 'test'
  assert_failure
}
