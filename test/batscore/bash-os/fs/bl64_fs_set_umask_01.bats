setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_fs_set_umask: no args" {
  run bl64_fs_set_umask
  assert_success
}

@test "bl64_fs_set_umask: invalid args" {
  run bl64_fs_set_umask 'invalid'
  assert_failure
}
