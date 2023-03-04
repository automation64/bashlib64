setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_tf_setup: module setup ok" {
  run bl64_tf_setup
  assert_success
}
