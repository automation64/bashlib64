@test "bl64_rnd_get_alphanumeric: check length 1" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  length=1
  run bl64_rnd_get_alphanumeric $length
  assert_success

  assert_equal "${#output}" "$length"

}
