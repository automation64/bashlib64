setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_hlm_chart_upgrade: file parameter not existing" {
  run bl64_hlm_chart_upgrade '/xxx/yy/zzz/not_existing' 'test'
  assert_failure
}
