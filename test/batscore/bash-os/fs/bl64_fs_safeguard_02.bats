setup() {
  DEV_TEST_INIT_ONLY='YES'
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  unset DEV_TEST_INIT_ONLY
  TEST_SANDBOX="$(temp_make)"
  export TEST_SANDBOX
}

teardown() {

  temp_del "$TEST_SANDBOX"

}

@test "bl64_fs_safeguard: backup" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  test_file="${TEST_SANDBOX}/org"
  cat "${TESTMANSH_TEST_SAMPLES}/text_01.txt" > "$test_file"

  run bl64_fs_safeguard "$test_file"
  assert_success

  assert_not_exists "$test_file"
  assert_exists "${test_file}${BL64_FS_ARCHIVE_POSTFIX}"

}
