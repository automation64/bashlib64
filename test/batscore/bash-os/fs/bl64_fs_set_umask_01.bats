@test "bl64_fs_set_umask: no args" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_fs_set_umask
  assert_success
}

@test "bl64_fs_set_umask: invalid args" {
  run bl64_fs_set_umask 'invalid'
  assert_failure
}
