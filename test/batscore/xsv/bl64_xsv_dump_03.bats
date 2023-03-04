setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_xsv_dump: file parameter not existing" {
  run bl64_xsv_dump '/xxx/yy/zzz/not_existing' 'test'
  assert_failure
}
