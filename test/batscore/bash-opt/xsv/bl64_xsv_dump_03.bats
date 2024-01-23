@test "bl64_xsv_dump: file parameter not existing" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_xsv_dump '/xxx/yy/zzz/not_existing' 'test'
  assert_failure
}
