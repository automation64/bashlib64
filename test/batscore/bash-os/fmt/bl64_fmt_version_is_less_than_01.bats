@test "bl64_fmt_version_is_less_than: missing 2 args" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_fmt_version_is_less_than
  assert_failure
}

@test "bl64_fmt_version_is_less_than: missing 1 arg" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_fmt_version_is_less_than '1.2.3'
  assert_failure
}

@test "bl64_fmt_version_is_less_than: wrong type" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_fmt_version_is_less_than 'a.b.c'
  assert_failure
}

@test "bl64_fmt_version_is_less_than: wrong type 2" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_fmt_version_is_less_than 'v2..2.31'
  assert_failure
}

