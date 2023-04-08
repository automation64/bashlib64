setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_k8s_setup || skip 'k8s cli not found'
}

@test "bl64_k8s_setup: module setup ok" {
  run bl64_k8s_setup
  assert_success
}

@test "bl64_k8s_setup: invalid path" {
  run bl64_k8s_setup '/invalid/path'
  assert_failure
}
