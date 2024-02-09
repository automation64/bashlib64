@test "bl64_check_privilege_root: is not root" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_check_privilege_root
  assert_failure

}

@test "bl64_check_privilege_root: is root" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run $BL64_RBAC_ALIAS_SUDO_ENV /usr/bin/env bash -c "source $DEV_TEST_BASHLIB64; bl64_check_privilege_root"
  assert_success

}
