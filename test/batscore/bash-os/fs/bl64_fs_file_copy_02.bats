setup() {
  DEV_TEST_INIT_ONLY='YES'
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  unset DEV_TEST_INIT_ONLY
  BATSLIB_TEMP_PRESERVE=0
  BATSLIB_TEMP_PRESERVE_ON_FAILURE=1

  TEST_SANDBOX="$(temp_make)"
  TEST_SOURCE="$TESTMANSH_TEST_SAMPLES"
  TEST_FILE1='text_01.txt'
  TEST_FILE2='text_02.txt'
}

@test "bl64_fs_file_copy: copy files" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_fs_file_copy \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$TEST_SANDBOX" \
    "${TEST_SOURCE}/${TEST_FILE1}" \
    "${TEST_SOURCE}/${TEST_FILE2}"
  assert_success
  assert_file_exist "${TEST_SANDBOX}/${TEST_FILE1}"
  assert_file_exist "${TEST_SANDBOX}/${TEST_FILE2}"
}

@test "bl64_fs_file_copy: copy files + missing target" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_fs_file_copy \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "/fake/destination" \
    "${TEST_SOURCE}/${TEST_FILE1}" \
    "${TEST_SOURCE}/${TEST_FILE2}"
  assert_failure
}

@test "bl64_fs_file_copy: copy files + missing source" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_fs_file_copy \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$TEST_SANDBOX" \
    "/fake/source" \
    "${TEST_SOURCE}/${TEST_FILE2}"
  assert_failure
}


teardown() {
  temp_del "$TEST_SANDBOX"
}
