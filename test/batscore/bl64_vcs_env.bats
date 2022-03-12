setup() {
  . "$DEVBL_TEST_BASHLIB64"
  . "${DEVBL_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-file/load.bash"

}

@test "bl64_vcs_env: public constants are set" {
  assert_equal $BL64_VCS_ERROR_MISSING_PARAMETER 200
  assert_equal $BL64_VCS_ERROR_DESTINATION_ERROR 201
  assert_equal $BL64_VCS_ERROR_MISSING_COMMAND 202
}
