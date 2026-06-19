@test "bl64_py_run_pipx: run pipx" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_cnt_is_inside_container || skip 'test-case for container mode'
  command -v pipx > /dev/null || skip 'pipx not installed'
  bl64_py_setup

  run bl64_py_run_pipx

  assert_success
}
