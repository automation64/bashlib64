setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_tf_setup || skip 'terraform cli not found'
}

@test "bl64_tf_set_logging: default" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_tf_setup
  run bl64_tf_set_logging
  assert_success
}

@test "bl64_tf_set_logging: path" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_tf_setup
  run bl64_tf_set_logging /tmp
  assert_success
}

@test "bl64_tf_set_logging: path and level" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_tf_setup
  run bl64_tf_set_logging /tmp DEBUG
  assert_success
}