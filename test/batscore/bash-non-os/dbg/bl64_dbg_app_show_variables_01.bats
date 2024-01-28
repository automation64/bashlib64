@test "bl64_dbg_app_show_variables: run ok" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_dbg_app_show_variables
  assert_success
}