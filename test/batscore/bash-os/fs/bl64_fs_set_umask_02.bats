@test "bl64_fs_set_umask: BL64_FS_UMASK_RW_USER" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_fs_set_umask "$BL64_FS_UMASK_RW_USER"
  run umask -S
  assert_success
  assert_output 'u=rwx,g=,o='
}

@test "bl64_fs_set_umask: BL64_FS_UMASK_RW_GROUP_RO_ALL" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_fs_set_umask "$BL64_FS_UMASK_RW_GROUP_RO_ALL"
  run umask -S
  assert_success
  assert_output 'u=rwx,g=rwx,o=rx'
}
