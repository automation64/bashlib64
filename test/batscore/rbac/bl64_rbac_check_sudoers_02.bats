setup() {
  . "$DEVBL_TEST_SETUP"

}

@test "bl64_rbac_check_sudoers: check ok" {
  if [[ ! -f '/run/.containerenv' ]]; then
    skip 'this case can only be tested inside a container'
  fi
  run $BL64_RBAC_ALIAS_SUDO_ENV /usr/bin/env bash -c "source $DEVBL_TEST_BASHLIB64; bl64_rbac_check_sudoers ${DEVBL_SAMPLES}/sudoers/sudoers_01"
  assert_success
}

@test "bl64_rbac_check_sudoers: check not ok" {
  if [[ ! -f '/run/.containerenv' ]]; then
    skip 'this case can only be tested inside a container'
  fi
  run $BL64_RBAC_ALIAS_SUDO_ENV /usr/bin/env bash -c "source $DEVBL_TEST_BASHLIB64; bl64_rbac_check_sudoers ${DEVBL_SAMPLES}/sudoers/sudoers_02"
  assert_failure
}
