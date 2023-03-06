setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_txt_replace_env: file parameter not existing" {
  run bl64_txt_replace_env '/xxx/yy/zzz/not_existing' 'test'
  assert_failure
}
