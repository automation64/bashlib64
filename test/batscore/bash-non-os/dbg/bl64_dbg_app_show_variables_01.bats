setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_dbg_app_show_variables: run ok" {
  run bl64_dbg_app_show_variables
  assert_success
}