setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_arc_setup
}

@test "bl64_arc_run_tar: CLI runs ok" {
  run bl64_arc_run_tar --version
  assert_success
}

@test "bl64_arc_run_tar: parameters are present" {
  run bl64_arc_run_tar
  assert_failure
}
