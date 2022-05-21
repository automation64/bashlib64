setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_iam_user_add: function parameter missing" {
  run bl64_iam_user_add
  assert_failure
}

@test "bl64_iam_user_add: add regular user" {
  [[ ! -f '/run/.containerenv' ]] && skip 'test-case for container mode'
  run $BL64_RBAC_ALIAS_SUDO_ENV /usr/bin/env bash -c "source $DEVBL_TEST_BASHLIB64; bl64_iam_user_add testusr"
  assert_success
}
