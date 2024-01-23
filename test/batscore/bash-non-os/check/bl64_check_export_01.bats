@test "bl64_check_export: export is present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  export TEST_EXPORTED_VARIABLE=1
  run bl64_check_export 'TEST_EXPORTED_VARIABLE' 'TEST_EXPORTED_VARIABLE'
  assert_success

}

@test "bl64_check_export: export is not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_check_export 'FAKE_EXPORTED_VARIABLE'
  assert_failure
  assert_equal "$status" $BL64_LIB_ERROR_EXPORT_SET

}

@test "bl64_check_export: export is empty" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  export TEST_EXPORTED_VARIABLE2=''
  run bl64_check_export 'TEST_EXPORTED_VARIABLE2'
  assert_failure
  assert_equal "$status" $BL64_LIB_ERROR_EXPORT_EMPTY

}

@test "bl64_check_export: parameter export is not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_check_export
  assert_failure

}
