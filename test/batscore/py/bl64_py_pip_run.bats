setup() {
  . "$DEVBL_TEST_SETUP"
}

@test "bl64_py_run_pip: run pip" {
  if [[ ! -f '/run/.containerenv' ]]; then
    skip 'this case can only be tested inside a container'
  fi

  run bl64_py_run_pip
  set -u

  assert_success
}
