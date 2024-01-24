@test "bl64_arc_run_tar: CLI runs ok" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_arc_setup
  run bl64_arc_run_tar --version
  assert_success
}

@test "bl64_arc_run_tar: parameters are present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_arc_run_tar
  assert_failure
}
