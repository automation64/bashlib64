@test "_bl64_lib_function_deprecated: no args" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  export BL64_LIB_DEPRECATION=OFF
  run _bl64_lib_function_deprecated
  assert_success
}

@test "_bl64_lib_function_deprecated: 1 args" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  export BL64_LIB_DEPRECATION=OFF
  run _bl64_lib_function_deprecated A
  assert_success
}

@test "_bl64_lib_function_deprecated: 2 args" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  export BL64_LIB_DEPRECATION=OFF
  run _bl64_lib_function_deprecated A B
  assert_success
}
