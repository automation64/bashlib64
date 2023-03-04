setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  BATSLIB_TEMP_PRESERVE=0
  BATSLIB_TEMP_PRESERVE_ON_FAILURE=1

  TEST_SANDBOX="$(temp_make)"
}

@test "bl64_fs_create_dir: default mode,owner + 2 dirs" {

  bl64_cnt_is_inside_container || skip 'test-case for container mode'

  target1="$TEST_SANDBOX/target1"
  target2="$TEST_SANDBOX/target2"

  run bl64_fs_create_dir "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" "$target1" "$target2"
  assert_success
  assert_dir_exist "${target1}"
  assert_dir_exist "${target2}"
}

@test "bl64_fs_create_dir: mode + default owner + 2 dirs" {

  bl64_cnt_is_inside_container || skip 'test-case for container mode'

  target1="$TEST_SANDBOX/target3"
  target2="$TEST_SANDBOX/target4"

  run bl64_fs_create_dir '0777' "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" "$target1" "$target2"
  assert_success
  assert_dir_exist "${target1}"
  assert_dir_exist "${target2}"
}

teardown() {
  temp_del "$TEST_SANDBOX"
}
