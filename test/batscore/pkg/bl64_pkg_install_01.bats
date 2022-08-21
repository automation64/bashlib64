setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

}

@test "bl64_pkg_install: install package + no root" {
  [[ ! -f '/run/.containerenv' ]] && skip 'test-case for container mode'
  run bl64_pkg_install file
  assert_failure
}
