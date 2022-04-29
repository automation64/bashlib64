setup() {
  . "$DEVBL_TEST_SETUP"
}

@test "bl64_rnd_get_numeric: check length" {

  local length=10

  test="$(bl64_rnd_get_numeric $length)"
  (( ${#test} == length ))

}
