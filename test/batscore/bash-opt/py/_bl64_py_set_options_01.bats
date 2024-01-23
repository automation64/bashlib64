setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "_bl64_py_set_options: common globals are set" {
  bl64_py_setup

  assert_not_equal "$BL64_PY_SET_PIP_VERBOSE" ''
  assert_not_equal "$BL64_PY_SET_PIP_VERSION" ''
  assert_not_equal "$BL64_PY_SET_PIP_UPGRADE" ''
  assert_not_equal "$BL64_PY_SET_PIP_USER" ''
  assert_not_equal "$BL64_PY_SET_PIP_DEBUG" ''
  assert_not_equal "$BL64_PY_SET_PIP_QUIET" ''
  assert_not_equal "$BL64_PY_SET_PIP_SITE" ''
  assert_not_equal "$BL64_PY_SET_PIP_NO_WARN_SCRIPT" ''
}
