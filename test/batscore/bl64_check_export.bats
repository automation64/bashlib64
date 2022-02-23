setup() {
  BL64_LIB_STRICT=0
  . "$DEVBL64_TEST_BASHLIB64"
  . "${DEVBL64_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL64_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL64_BATS_HELPER}/bats-file/load.bash"

}

@test "bl64_check_export: export is present" {

  export TEST_EXPORTED_VARIABLE=1
  run bl64_check_export 'TEST_EXPORTED_VARIABLE' 'TEST_EXPORTED_VARIABLE'
  assert_success

}

@test "bl64_check_export: export is not present" {

  run bl64_check_export 'FAKE_EXPORTED_VARIABLE'
  assert_equal "$status" $BL64_CHECK_ERROR_EXPORT_SET
  assert_output --partial "${_BL64_CHECK_TXT_EXPORT_SET}"

}

@test "bl64_check_export: export is empty" {

  export TEST_EXPORTED_VARIABLE2=''
  run bl64_check_export 'TEST_EXPORTED_VARIABLE2'
  assert_equal "$status" $BL64_CHECK_ERROR_EXPORT_EMPTY
  assert_output --partial "${_BL64_CHECK_TXT_EXPORT_EMPTY}"

}

@test "bl64_check_export: function export is not present" {

  run bl64_check_export
  assert_equal "$status" $BL64_CHECK_ERROR_MISSING_PARAMETER
  assert_output --partial "${_BL64_CHECK_TXT_MISSING_PARAMETER}"

}
