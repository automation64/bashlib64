@test "bl64_txt_line_replace_sed: parameters are not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_txt_line_replace_sed
  assert_failure
}
