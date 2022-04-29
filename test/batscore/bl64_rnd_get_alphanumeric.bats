setup() {
  . "$DEVBL_TEST_SETUP"
}

@test "bl64_rnd_get_alphanumeric: check length 1" {

  length=1
  run bl64_rnd_get_alphanumeric $length
  assert_success

  assert_equal "${#output}" "$length"

}

@test "bl64_rnd_get_alphanumeric: check length 20" {

  length=20
  run bl64_rnd_get_alphanumeric $length
  assert_success

  assert_equal "${#output}" "$length"

}

@test "bl64_rnd_get_alphanumeric: check length 50" {

  length=50
  run bl64_rnd_get_alphanumeric $length
  assert_success

  assert_equal "${#output}" "$length"

}
