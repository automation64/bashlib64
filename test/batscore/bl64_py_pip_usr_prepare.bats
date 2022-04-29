setup() {
  . "$DEVBL_TEST_SETUP"
}

@test "bl64_py_pip_usr_prepare: run prepare" {
  if [[ ! -f '/run/.containerenv' ]]; then
    skip 'this case can only be tested inside a container'
  fi

  run bl64_py_pip_usr_prepare
  set -u

  assert_success
}
