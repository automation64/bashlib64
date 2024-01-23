setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_arc_run_unzip: both parameters are not present" {
  bl64_arc_setup
  run bl64_arc_run_unzip
  assert_failure
}

