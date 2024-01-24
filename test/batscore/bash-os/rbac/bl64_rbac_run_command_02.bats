@test "bl64_rbac_run_command: run with exit status ok" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_cnt_is_inside_container || skip 'test-case for container mode'
  run bl64_rbac_run_command 'root' "$BL64_OS_CMD_TRUE"
  assert_success
}

@test "bl64_rbac_run_command: run with exit status error" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_cnt_is_inside_container || skip 'test-case for container mode'

  run bl64_rbac_run_command 'root' "$BL64_OS_CMD_FALSE"
  assert_failure
}
