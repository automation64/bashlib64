@test "bl64_fmt_version_is_less_than: are equal" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_fmt_version_is_less_than '1.2.4' '1.2.4'
  assert_failure
}
