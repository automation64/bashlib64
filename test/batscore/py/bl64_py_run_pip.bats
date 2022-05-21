setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_py_setup
}

@test "bl64_py_run_pip: run pip" {
  [[ ! -f '/run/.containerenv' ]] && skip 'test-case for container mode'

  run bl64_py_run_pip
  set -u

  assert_success
}
