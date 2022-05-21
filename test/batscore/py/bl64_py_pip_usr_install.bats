setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_py_setup
}

@test "bl64_py_pip_usr_install: run prepare" {
  [[ ! -f '/run/.containerenv' ]] && skip 'test-case for container mode'

  run bl64_py_pip_usr_install 'pip-install-test'
  set -u

  assert_success
}
