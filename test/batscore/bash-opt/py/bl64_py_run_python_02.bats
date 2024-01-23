setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  [[ ! -x "$BL64_PY_CMD_PYTHON3" ]] && skip 'python3 not found'
}

@test "bl64_py_run_python: CLI runs ok" {
  bl64_py_setup

  run bl64_py_run_python --version
  assert_success
}
