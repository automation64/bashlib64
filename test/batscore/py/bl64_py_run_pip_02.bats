setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_py_setup
}

@test "bl64_py_run_pip: run pip + ephemeral" {
  [[ ! -f '/run/.containerenv' ]] && skip 'test-case for container mode'

  export BL64_FS_PATH_TEMPORAL=/tmp
  export BL64_FS_PATH_CACHE=/tmp

  run bl64_py_run_pip
  set -u

  assert_success
}
