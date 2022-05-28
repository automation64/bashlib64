setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

}

@test "bl64_rbac_run_command: run ok" {
  [[ ! -f '/run/.containerenv' ]] && skip 'test-case for container mode'
  run bl64_rbac_run_command 'root' "$BL64_OS_CMD_TRUE"
  assert_success
}

@test "bl64_rbac_run_command: run error" {
  [[ ! -f '/run/.containerenv' ]] && skip 'test-case for container mode'
  run bl64_rbac_run_command 'root' "$BL64_OS_CMD_FALSE"
  assert_failure
}
