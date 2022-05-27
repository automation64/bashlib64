setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

}

@test "bl64_rbac_run_command: no args" {
  [[ ! -f '/run/.containerenv' ]]
  run bl64_rbac_run_command
  assert_failure
}

@test "bl64_rbac_run_command: 1 arg" {
  run bl64_rbac_run_command 'root'
  assert_failure
}
