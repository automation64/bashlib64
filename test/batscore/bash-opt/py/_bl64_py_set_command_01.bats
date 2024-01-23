@test "_bl64_py_set_command: commands are set" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_py_setup
  assert_not_equal "$BL64_PY_CMD_PYTHON3" ''
  assert_not_equal "$BL64_PY_CMD_PYTHON35" ''
  assert_not_equal "$BL64_PY_CMD_PYTHON36" ''
  assert_not_equal "$BL64_PY_CMD_PYTHON37" ''
  assert_not_equal "$BL64_PY_CMD_PYTHON38" ''
  assert_not_equal "$BL64_PY_CMD_PYTHON39" ''
  assert_not_equal "$BL64_PY_CMD_PYTHON310" ''
}
