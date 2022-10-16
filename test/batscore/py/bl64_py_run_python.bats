setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  [[ ! -x "$BL64_PY_CMD_PYTHON3" ]] && skip
  bl64_py_setup
}

@test "bl64_py_run_python: CLI runs ok" {

  run bl64_py_run_python --version
  assert_success
}
