setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_py_setup
}

@test "bl64_py_set_options: common globals are set" {

  assert_not_equal "$BL64_PY_SET_PIP_VERBOSE" ''
  assert_not_equal "$BL64_PY_SET_PIP_VERSION" ''
  assert_not_equal "$BL64_PY_SET_PIP_UPGRADE" ''
  assert_not_equal "$BL64_PY_SET_PIP_USER" ''
  assert_not_equal "$BL64_PY_SET_PIP_DEBUG" ''
  assert_not_equal "$BL64_PY_SET_PIP_QUIET" ''
  assert_not_equal "$BL64_PY_SET_PIP_SITE" ''
  assert_not_equal "$BL64_PY_SET_PIP_NO_WARN_SCRIPT" ''

  assert_not_equal "$BL64_PY_DEF_VENV_CFG" ''
  assert_not_equal "$BL64_PY_DEF_MODULE_VENV" ''
  assert_not_equal "$BL64_PY_DEF_MODULE_PIP" ''

}
