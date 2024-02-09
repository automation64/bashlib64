@test "bl64_arc_blank_unzip: run ok" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_arc_setup
  run bl64_arc_blank_unzip
  assert_success
}

