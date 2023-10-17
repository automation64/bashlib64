setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_arc_setup
}

@test "bl64_arc_run_unzip: both parameters are not present" {
  run bl64_arc_run_unzip
  assert_failure
}

