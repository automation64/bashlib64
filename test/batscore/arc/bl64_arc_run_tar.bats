setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_arc_run_tar: CLI runs ok" {
  [[ ! -x "$BL64_PY_CMD_PYTHON3" ]] && skip

  run bl64_arc_run_tar --version
  assert_success
}
