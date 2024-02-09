@test "bl64_check_module: module not sourced" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_check_module 'BL64_XXX_MODULE'
  assert_failure

}

@test "bl64_check_module: module sourced" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_check_module 'BL64_OS_MODULE'
  assert_success

}

@test "bl64_check_module: module not setup" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  declare BL64_XXX_MODULE='0'
  run bl64_check_module 'BL64_XXX_MODULE'
  assert_failure

}
