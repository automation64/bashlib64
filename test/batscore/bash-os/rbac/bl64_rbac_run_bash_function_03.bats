setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

}

@test "bl64_rbac_run_bash_function: file parameter not existing" {
  run bl64_rbac_run_bash_function '/xxx/yy/zzz/not_existing' 'test'
  assert_failure
}
