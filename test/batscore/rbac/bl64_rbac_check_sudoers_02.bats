setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

}

@test "bl64_rbac_check_sudoers: check ok" {
  [[ ! -f '/run/.containerenv' ]] && skip 'test-case for container mode'
  run $BL64_RBAC_ALIAS_SUDO_ENV /usr/bin/env bash -c "source $DEVBL_TEST_BASHLIB64; bl64_rbac_check_sudoers ${DEVBL_SAMPLES}/sudoers/sudoers_01"
  assert_success
}

@test "bl64_rbac_check_sudoers: check not ok" {
  [[ ! -f '/run/.containerenv' ]] && skip 'test-case for container mode'
  run $BL64_RBAC_ALIAS_SUDO_ENV /usr/bin/env bash -c "source $DEVBL_TEST_BASHLIB64; bl64_rbac_check_sudoers ${DEVBL_SAMPLES}/sudoers/sudoers_02"
  assert_failure
}
