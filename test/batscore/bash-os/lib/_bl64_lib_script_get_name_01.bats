@test "_bl64_lib_script_get_name: result" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run _bl64_lib_script_get_name
  assert_success
}
