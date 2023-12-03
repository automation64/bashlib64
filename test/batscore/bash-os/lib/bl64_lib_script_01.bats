setup() {
  export DEV_TEST_INIT_ONLY='YES'
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_lib_source: script vars are set" {

  export _DEV_LIB_BASHLIB64_BUILD="${DEV_TEST_PATH_LIBRARY}/bashlib64.bash"
  run "${TESTMANSH_TEST_SAMPLES}/script_01/template" -t
  assert_success
  assert_output 'sample_script_test'

}
