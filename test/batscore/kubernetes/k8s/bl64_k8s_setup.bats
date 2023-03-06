setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_k8s_setup: module setup ok" {
  run bl64_k8s_setup
  assert_success
}
