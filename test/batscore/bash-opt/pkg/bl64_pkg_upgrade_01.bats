@test "bl64_pkg_upgrade: upgrade packages + explicit sudo" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_os_is_distro 'UB-21.04' && skip 'UB-21.04 is EOL'
  bl64_cnt_is_inside_container || skip 'test-case for container mode'
  run $BL64_RBAC_ALIAS_SUDO_ENV /usr/bin/env bash -c "source $DEV_TEST_BASHLIB64; bl64_pkg_setup; bl64_pkg_upgrade"
  assert_success
}
