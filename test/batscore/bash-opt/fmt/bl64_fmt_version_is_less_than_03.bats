@test "bl64_fmt_version_is_less_than: is not less than - A" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_fmt_version_is_less_than '1.2.4' '1.2.3'
  assert_failure
}

@test "bl64_fmt_version_is_less_than: is not less than - B" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_fmt_version_is_less_than '1.3.3' '1.2.3'
  assert_failure
}

@test "bl64_fmt_version_is_less_than: is not less than - C" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_fmt_version_is_less_than '2.2.3' '1.2.3'
  assert_failure
}

@test "bl64_fmt_version_is_less_than: is not less than - D" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_fmt_version_is_less_than '3.4.5' '2.3.4'
  assert_failure
}