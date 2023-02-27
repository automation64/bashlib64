setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_tf_setup || skip 'terraform cli not found'
}

@test "bl64_tf_run_terraform: CLI runs ok" {
  run bl64_tf_run_terraform --help
  assert_success
}
