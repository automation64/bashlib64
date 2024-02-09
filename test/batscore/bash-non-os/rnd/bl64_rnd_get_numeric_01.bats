@test "bl64_rnd_get_numeric: check length" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  local length=10

  test="$(bl64_rnd_get_numeric $length)"
  (( ${#test} == length ))

}
