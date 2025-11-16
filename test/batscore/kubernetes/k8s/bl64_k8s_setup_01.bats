setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  [[ -x /usr/local/bin/kubectl ]] || skip 'k8s cli not found'
}

@test "bl64_k8s_setup: module setup ok" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_k8s_setup
  assert_success
}

@test "bl64_k8s_setup: invalid path" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_k8s_setup '/invalid/path'
  assert_success
}
