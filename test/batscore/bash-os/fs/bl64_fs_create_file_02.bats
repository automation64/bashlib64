@test "bl64_fs_create_file: create file" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_cnt_is_inside_container || skip 'test-case for container mode'
  run bl64_fs_create_file /tmp/${RANDOM}
  assert_success
}
