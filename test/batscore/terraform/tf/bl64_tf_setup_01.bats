setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  [[ -x /usr/local/bin/terraform ]] || skip 'terraform cli not found'
}

@test "bl64_tf_setup: module setup ok" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_tf_setup
  assert_success
}

@test "bl64_tf_setup: invalid path" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_tf_setup '/1/2/3'
  assert_failure
}
