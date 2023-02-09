setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_check_module: no param" {

  run bl64_check_module
  assert_failure

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
  export BL64_XXX_MODULE="$BL64_VAR_OFF"
  run bl64_check_module 'BL64_XXX_MODULE'
  assert_failure

}
