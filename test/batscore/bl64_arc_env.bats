setup() {
  . "$DEVBL64_TEST_BASHLIB64"
  . "${DEVBL64_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL64_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL64_BATS_HELPER}/bats-file/load.bash"

}

@test "bl64_arc_env: public constants are set" {
  assert_equal $BL64_ARC_ERROR_MISSING_PARAMETER 200
  assert_equal $BL64_ARC_ERROR_INVALID_DESTINATION 201
}
