setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  BATSLIB_TEMP_PRESERVE=0
  BATSLIB_TEMP_PRESERVE_ON_FAILURE=1

  TEST_SANDBOX="$(temp_make)"
}

@test "bl64_fs_set_ephemeral: set all" {
  tmp="${TEST_SANDBOX}/tmp"
  cache="${TEST_SANDBOX}/tmp"

  run bl64_fs_set_ephemeral "$tmp" "$cache"
  assert_equal "$status" '0'
  assert_dir_exist "$tmp"
  assert_dir_exist "$cache"
}

teardown() {
  temp_del "$TEST_SANDBOX"
}
