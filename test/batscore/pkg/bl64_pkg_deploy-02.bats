setup() {
  . "$DEVBL_TEST_SETUP"

}

@test "bl64_pkg_deploy: deploy package + explicit sudo" {
  if [[ ! -f '/run/.containerenv' ]]; then
    skip 'this case can only be tested inside a container'
  fi
  run $BL64_RBAC_ALIAS_SUDO_ENV /bin/bash -c "source $DEVBL_TEST_BASHLIB64; bl64_pkg_deploy file"
  assert_success
}
