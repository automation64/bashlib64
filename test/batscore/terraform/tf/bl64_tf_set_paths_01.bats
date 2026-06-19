setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_tf_setup || skip 'terraform cli not found'
}

@test "bl64_tf_set_paths: default" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_tf_setup
  run bl64_tf_set_paths
  assert_success
}

@test "bl64_tf_set_paths: custom" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_tf_setup
  run bl64_tf_set_paths /tmp/test
  assert_success
}
