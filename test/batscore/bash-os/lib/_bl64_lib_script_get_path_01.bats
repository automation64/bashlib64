@test "_bl64_lib_script_get_path: result" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run _bl64_lib_script_get_path
  assert_success
}
