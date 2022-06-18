setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_check_path_not_present: file is present" {

  run bl64_check_path_not_present "$BL64_FS_CMD_CP"
  assert_failure

}

@test "bl64_check_path_not_present: file is not present" {

  run bl64_check_path_not_present '/fake/file'
  assert_success

}

@test "bl64_check_path_not_present: parameter not present" {

  run bl64_check_path_not_present
  assert_failure

}
