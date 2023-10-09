setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_fs_check_new_dir: dir not present, ok" {
  run bl64_fs_check_new_dir '/tmp/new_dir'
  assert_success
}

@test "bl64_fs_check_new_dir: dir not present, not ok" {
  run bl64_fs_check_new_dir '/etc/hosts'
  assert_failure
}

@test "bl64_fs_check_new_dir: dir present, ok" {
  run bl64_fs_check_new_dir '/tmp'
  assert_success
}

@test "bl64_fs_check_new_dir: dir present, not ok" {
  run bl64_fs_check_new_dir '/etc/hosts'
  assert_failure
}
