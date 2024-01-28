@test "bl64_pkg_deploy: deploy package + no root" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_pkg_setup
  bl64_cnt_is_inside_container || skip 'test-case for container mode'
  run bl64_pkg_deploy file
  assert_failure
}
