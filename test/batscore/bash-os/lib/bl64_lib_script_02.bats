setup() {
  export DEV_TEST_INIT_ONLY='YES'
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_lib_script: run nested script" {
  run "${TESTMANSH_TEST_SAMPLES}/script_02/first"
  assert_success
  assert_output ''
}
