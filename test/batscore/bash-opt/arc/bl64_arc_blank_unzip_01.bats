setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_arc_blank_unzip: run ok" {
  bl64_arc_setup
  run bl64_arc_blank_unzip
  assert_success
}

