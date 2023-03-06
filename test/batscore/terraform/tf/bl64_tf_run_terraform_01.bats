setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_tf_setup || skip 'terraform cli not found'
}

@test "bl64_tf_run_terraform: parameters are not present" {
  run bl64_tf_run_terraform
  assert_failure
}