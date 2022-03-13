setup() {
  . "$DEVBL_TEST_BASHLIB64"
  . "${DEVBL_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-file/load.bash"
}

@test "bl64_rnd_get_alphanumeric: check length 1" {

  length=1
  set +u # to avoid IFS missing error in run function
  run bl64_rnd_get_alphanumeric $length
  assert_success

  assert_equal "${#output}" "$length"

}

@test "bl64_rnd_get_alphanumeric: check length 20" {

  length=20
  set +u # to avoid IFS missing error in run function
  run bl64_rnd_get_alphanumeric $length
  assert_success

  assert_equal "${#output}" "$length"

}

@test "bl64_rnd_get_alphanumeric: check length 50" {

  length=50
  set +u # to avoid IFS missing error in run function
  run bl64_rnd_get_alphanumeric $length
  assert_success

  assert_equal "${#output}" "$length"

}
