setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_tf_setup || skip 'terraform cli not found'
}

@test "bl64_tf_setup: module setup ok" {
  run bl64_tf_setup
  assert_success
}
