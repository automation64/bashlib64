function _bl64_lib_script_set_id() {
  bl64_lib_script_set_id "$1" &&
    echo "$BL64_SCRIPT_ID"
}

@test "bl64_lib_script_set_id: no args" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_lib_script_set_id
  assert_failure
}

@test "bl64_lib_script_set_id: with args" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  expected='test-id'
  run _bl64_lib_script_set_id "$expected"
  assert_success
  assert_output "$expected"
}
