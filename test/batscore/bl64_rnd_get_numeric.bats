setup() {
  . "$DEVBL_TEST_BASHLIB64"
  . "${DEVBL_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-file/load.bash"
}

@test "bl64_rnd_get_numeric: check length" {

  local length=10

  test="$(bl64_rnd_get_numeric $length)"
  (( ${#test} == length ))

}
