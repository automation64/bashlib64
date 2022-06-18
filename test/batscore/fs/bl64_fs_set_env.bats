setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

}

@test "bl64_fs_set_env: umask permissions" {

    assert_equal "$BL64_FS_UMASK_RW_USER" 'u=rwx,g=,o='
    assert_equal "$BL64_FS_UMASK_RW_GROUP" 'u=rwx,g=rwx,o='
    assert_equal "$BL64_FS_UMASK_RW_ALL" 'u=rwx,g=rwx,o=rwx'
    assert_equal "$BL64_FS_UMASK_RW_USER_RO_ALL" 'u=rwx,g=rx,o=rx'
    assert_equal "$BL64_FS_UMASK_RW_GROUP_RO_ALL" 'u=rwx,g=rwx,o=rx'

}
