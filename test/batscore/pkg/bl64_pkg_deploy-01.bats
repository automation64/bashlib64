setup() {
  . "$DEVBL_TEST_SETUP"

}

@test "bl64_pkg_deploy: deploy package + no root" {
  if [[ ! -f '/run/.containerenv' ]]; then
    skip 'this case can only be tested inside a container'
  fi
  run bl64_pkg_deploy file
  assert_failure
}
