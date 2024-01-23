@test "bl64_rbac_check_sudoers: check ok" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_cnt_is_inside_container || skip 'test-case for container mode'
  run $BL64_RBAC_ALIAS_SUDO_ENV /usr/bin/env bash -c "source $DEV_TEST_BASHLIB64; bl64_rbac_check_sudoers ${TESTMANSH_TEST_SAMPLES}/sudoers/sudoers_01"
  assert_success
}

@test "bl64_rbac_check_sudoers: check not ok" {
  bl64_cnt_is_inside_container || skip 'test-case for container mode'
  run $BL64_RBAC_ALIAS_SUDO_ENV /usr/bin/env bash -c "source $DEV_TEST_BASHLIB64; bl64_rbac_check_sudoers ${TESTMANSH_TEST_SAMPLES}/sudoers/sudoers_02"
  assert_failure
}
