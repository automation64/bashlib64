setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_iam_setup
}

@test "bl64_iam_user_add: add regular user + home + shell + geco" {
  bl64_cnt_is_inside_container || skip 'test-case for container mode'
  run $BL64_RBAC_ALIAS_SUDO_ENV /usr/bin/env bash -c "source $DEV_TEST_BASHLIB64; bl64_iam_user_add testusr2 /home/testx1 $BL64_VAR_DEFAULT /bin/sh testuser"
  assert_success
}
