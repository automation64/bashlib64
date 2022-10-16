setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_pkg_setup

}

@test "bl64_pkg_deploy: deploy package + no root" {
  [[ ! -f '/run/.containerenv' ]] && skip 'test-case for container mode'
  run bl64_pkg_deploy file
  assert_failure
}
