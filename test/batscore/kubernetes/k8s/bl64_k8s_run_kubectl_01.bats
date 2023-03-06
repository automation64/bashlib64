setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_k8s_run_kubectl: parameters are not present" {
  run bl64_k8s_run_kubectl
  assert_failure
}
