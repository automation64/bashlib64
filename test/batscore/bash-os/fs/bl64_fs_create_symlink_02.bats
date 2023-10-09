setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  BATSLIB_TEMP_PRESERVE=0
  BATSLIB_TEMP_PRESERVE_ON_FAILURE=1

  TEST_SANDBOX="$(temp_make)"
}

@test "bl64_fs_create_symlink: missing source" {
  run bl64_fs_create_symlink \
    "/fake/file" \
    "/not/needed"
  assert_failure
}

@test "bl64_fs_create_symlink: create ok, no previous" {
  test_destination="${TEST_SANDBOX}/test1"

  run bl64_fs_create_symlink \
    "/etc/hosts" \
    "$test_destination"

  assert_success
  assert_file_exist "$test_destination"
}

@test "bl64_fs_create_symlink: create ok, previous overwrite" {
  test_destination="${TEST_SANDBOX}/test1"

  run bl64_fs_create_symlink \
    "/etc/hosts" \
    "$test_destination"

  run bl64_fs_create_symlink \
    "/etc/hosts" \
    "$test_destination" \
    "$BL64_VAR_ON"

  assert_success
  assert_file_exist "$test_destination"
}

@test "bl64_fs_create_symlink: create ok, previous no overwrite" {
  test_destination="${TEST_SANDBOX}/test1"

  run bl64_fs_create_symlink \
    "/etc/hosts" \
    "$test_destination"

  run bl64_fs_create_symlink \
    "/etc/hosts" \
    "$test_destination" \
    "$BL64_VAR_OFF"

  assert_success
  assert_file_exist "$test_destination"
}

teardown() {
  temp_del "$TEST_SANDBOX"
}
