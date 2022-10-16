setup() {
  [[ ! -f '/run/.containerenv' ]] && skip 'test-case for container mode'
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_py_setup
}

@test "bl64_py_pip_usr_prepare: run prepare" {

  run bl64_py_pip_usr_prepare
  set -u

  assert_success
}
