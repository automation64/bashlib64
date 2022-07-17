setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_tf_run_terraform: CLI runs ok" {
  bl64_tf_setup || skip
  run bl64_tf_run_terraform --help
  assert_success
}
