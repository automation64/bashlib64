setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

}

@test "bl64_pkg_deploy: deploy package + explicit sudo" {
  [[ ! -f '/run/.containerenv' ]] && skip 'test-case for container mode'
  run $BL64_RBAC_ALIAS_SUDO_ENV /usr/bin/env bash -c "source $DEVBL_TEST_BASHLIB64; bl64_pkg_deploy file"
  assert_success
}

@test "bl64_pkg_deploy: deploy package + explicit sudo + verbose" {
  [[ ! -f '/run/.containerenv' ]] && skip 'test-case for container mode'
  export BL64_LIB_VERBOSE="2"
  run $BL64_RBAC_ALIAS_SUDO_ENV /usr/bin/env bash -c "source $DEVBL_TEST_BASHLIB64; bl64_pkg_deploy file"
  assert_success
}
