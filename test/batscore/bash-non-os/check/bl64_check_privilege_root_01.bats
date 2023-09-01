setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_check_privilege_root: is not root" {

  run bl64_check_privilege_root
  assert_failure

}

@test "bl64_check_privilege_root: is root" {

  run $BL64_RBAC_ALIAS_SUDO_ENV /usr/bin/env bash -c "source $DEVBL_TEST_BASHLIB64; bl64_check_privilege_root"
  assert_success

}
