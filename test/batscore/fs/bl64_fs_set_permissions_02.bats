setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  BATSLIB_TEMP_PRESERVE=0
  BATSLIB_TEMP_PRESERVE_ON_FAILURE=1

  TEST_SANDBOX="$(temp_make)"
  TEST_FILE="${TEST_SANDBOX}/test-file"
  touch "$TEST_FILE"
}

@test "bl64_fs_set_permissions: all defaults" {
  run bl64_fs_set_permissions \
    "$TEST_FILE" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT"
  assert_success
}

@test "bl64_fs_set_permissions: set perm" {
  run bl64_fs_set_permissions \
    "$TEST_FILE" \
    "0755" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT"
  assert_success
}

teardown() {
  temp_del "$TEST_SANDBOX"
}
