setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_fs_fix_permissions: no args" {
  run bl64_fs_fix_permissions
  assert_failure
}

@test "bl64_fs_fix_permissions: no path" {
  run bl64_fs_fix_permissions "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT"
  assert_failure
}
