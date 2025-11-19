@test "bl64_fmt_version_is_less_than: is less than - A" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_fmt_version_is_less_than '1.2.3' '1.2.4'
  assert_success
}

@test "bl64_fmt_version_is_less_than: is less than - B" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_fmt_version_is_less_than '1.2.3' '1.3.4'
  assert_success
}

@test "bl64_fmt_version_is_less_than: is less than - C" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_fmt_version_is_less_than '1.2.3' '2.3.4'
  assert_success
}

@test "bl64_fmt_version_is_less_than: is less than - D" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_fmt_version_is_less_than '1.2.5' '2.3.4'
  assert_success
}

@test "bl64_fmt_version_is_less_than: is less than - E" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_fmt_version_is_less_than '1.4.5' '2.3.4'
  assert_success
}
