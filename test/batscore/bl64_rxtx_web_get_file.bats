setup() {
  . "$DEVBL_TEST_BASHLIB64"
  . "${DEVBL_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-file/load.bash"
}

@test "bl64_rxtx_web_get_file: function parameter missing" {
  set +u # to avoid IFS missing error in run function
  run bl64_rxtx_web_get_file
  assert_equal "$status" $BL64_RXTX_ERROR_MISSING_PARAMETER
}
