setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  [[ -x /usr/local/bin/terraform || -x /usr/bin/terraform ]] || skip 'terraform cli not found'
}

@test "_bl64_tf_set_version: run ok" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_tf_setup
  run _bl64_tf_set_version
  assert_success
}
