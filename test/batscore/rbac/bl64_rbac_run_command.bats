setup() {
  . "$DEVBL_TEST_SETUP"

}

@test "bl64_rbac_run_command: run ok" {
  if [[ ! -f '/run/.containerenv' ]]; then
    skip 'this case can only be tested inside a container'
  fi
  run bl64_rbac_run_command "$BL64_OS_CMD_TRUE"
  assert_success
}

@test "bl64_rbac_run_command: run error" {
  if [[ ! -f '/run/.containerenv' ]]; then
    skip 'this case can only be tested inside a container'
  fi
  run bl64_rbac_run_command "$BL64_OS_CMD_FALSE"
  assert_failure
}
