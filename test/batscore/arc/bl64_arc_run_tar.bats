setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_arc_setup
}

@test "bl64_arc_run_tar: CLI runs ok" {
  [[ ! -x "$BL64_PY_CMD_PYTHON3" ]] && skip 'python3 not found'

  run bl64_arc_run_tar --version
  assert_success
}

@test "bl64_arc_run_tar: parameters are present" {
  run bl64_arc_run_tar
  assert_failure
}
