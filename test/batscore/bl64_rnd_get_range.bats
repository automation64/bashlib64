setup() {
  . "$DEVBL_TEST_BASHLIB64"
  . "${DEVBL_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-file/load.bash"
}

@test "bl64_rnd_get_range: check range" {

  local min=2
  local max=8

  test="$(bl64_rnd_get_range $min $max)"
  (( test <=  && test >= min ))

}
