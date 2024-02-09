@test "bl64_fs_fix_permissions: no args" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_fs_fix_permissions
  assert_failure
}

@test "bl64_fs_fix_permissions: no path" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_fs_fix_permissions "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT"
  assert_failure
}
