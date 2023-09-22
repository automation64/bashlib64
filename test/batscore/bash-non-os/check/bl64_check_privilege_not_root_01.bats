setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_check_privilege_not_root: is not root" {

  run bl64_check_privilege_not_root
  assert_success

}

@test "bl64_check_privilege_not_root: is root" {

  bl64_cnt_is_inside_container || skip 'test-case for container mode'
  run $BL64_RBAC_ALIAS_SUDO_ENV /usr/bin/env bash -c "source $DEV_TEST_BASHLIB64; bl64_check_privilege_not_root"
  assert_failure

}
