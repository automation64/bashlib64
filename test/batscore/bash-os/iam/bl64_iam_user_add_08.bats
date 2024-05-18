@test "bl64_iam_user_add: add regular user + existing group" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_cnt_is_inside_container || skip 'test-case for container mode'
  bl64_iam_setup
  user='testusr2'
  run $BL64_RBAC_ALIAS_SUDO_ENV /usr/bin/env bash -c "source $DEV_TEST_BASHLIB64; bl64_iam_group_add $user"
  run $BL64_RBAC_ALIAS_SUDO_ENV /usr/bin/env bash -c "source $DEV_TEST_BASHLIB64; bl64_iam_user_add $user $BL64_VAR_DEFAULT $user"
  assert_success
}
