setup() {
  . "$DEVBL_TEST_BASHLIB64"
  . "${DEVBL_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-file/load.bash"

}

@test "bl64_py_set_options: common globals are set" {

  assert_not_equal "$BL64_PY_SET_PIP_VERBOSE" ''
  assert_not_equal "$BL64_PY_SET_PIP_VERSION" ''
  assert_not_equal "$BL64_PY_SET_PIP_UPGRADE" ''
  assert_not_equal "$BL64_PY_SET_PIP_USER" ''

}
