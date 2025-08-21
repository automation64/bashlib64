@test "bl64_bsh_pattern_match_file: missing args" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_bsh_pattern_match_file
  assert_failure
}
