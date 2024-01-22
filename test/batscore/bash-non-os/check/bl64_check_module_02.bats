setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_check_module: module not sourced" {

  run bl64_check_module 'BL64_XXX_MODULE'
  assert_failure

}

@test "bl64_check_module: module sourced" {

  run bl64_check_module 'BL64_OS_MODULE'
  assert_success

}

@test "bl64_check_module: module not setup" {
  declare BL64_XXX_MODULE='0'
  run bl64_check_module 'BL64_XXX_MODULE'
  assert_failure

}
