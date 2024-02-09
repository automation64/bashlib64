@test "_bl64_py_set_command: commands are set" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_py_setup
  assert_not_equal "$BL64_PY_CMD_PYTHON3" ''
}
