@test "bl64_hlm_chart_upgrade: file parameter not existing" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_hlm_chart_upgrade '/xxx/yy/zzz/not_existing' 'test'
  assert_failure
}
