@test "bl64_pkg_repository_add: no args" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run $BL64_RBAC_ALIAS_SUDO_ENV /usr/bin/env bash -c "source $DEV_TEST_BASHLIB64; bl64_pkg_setup; bl64_pkg_repository_add"
  assert_failure
}
