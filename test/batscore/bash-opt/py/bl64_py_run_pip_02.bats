@test "bl64_py_run_pip: run pip + ephemeral" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_cnt_is_inside_container || skip 'test-case for container mode'
  bl64_py_setup

  export BL64_FS_PATH_TEMPORAL=/tmp
  export BL64_FS_PATH_CACHE=/tmp

  run bl64_py_run_pip
  set -u

  assert_success
}
