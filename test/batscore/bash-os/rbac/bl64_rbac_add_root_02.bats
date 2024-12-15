setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  export _TEST_USER='testuser'
  bl64_cnt_is_inside_container || skip 'test-case for container mode'
  bl64_iam_setup
  $BL64_RBAC_ALIAS_SUDO_ENV /usr/bin/env bash -c "source $DEV_TEST_BASHLIB64; bl64_iam_user_add $_TEST_USER"
}

@test "bl64_rbac_add_root: run ok" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run $BL64_RBAC_ALIAS_SUDO_ENV /usr/bin/env bash -c "source $DEV_TEST_BASHLIB64; bl64_rbac_add_root $_TEST_USER"
  assert_success
}
