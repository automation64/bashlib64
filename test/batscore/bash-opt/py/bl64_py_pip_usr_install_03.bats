setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  export TEST_SANDBOX

  BATSLIB_TEMP_PRESERVE=0
  BATSLIB_TEMP_PRESERVE_ON_FAILURE=1

  TEST_SANDBOX="$(temp_make)"

}

@test "bl64_py_pip_usr_install: parameters are not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_py_pip_usr_install
  assert_failure
}