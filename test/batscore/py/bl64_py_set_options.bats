setup() {
  . "$DEVBL_TEST_SETUP"

}

@test "bl64_py_set_options: common globals are set" {

  assert_not_equal "$BL64_PY_SET_PIP_VERBOSE" ''
  assert_not_equal "$BL64_PY_SET_PIP_VERSION" ''
  assert_not_equal "$BL64_PY_SET_PIP_UPGRADE" ''
  assert_not_equal "$BL64_PY_SET_PIP_USER" ''

}
