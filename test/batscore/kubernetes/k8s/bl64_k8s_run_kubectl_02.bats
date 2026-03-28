setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_k8s_setup || skip 'k8s cli not found'
}

@test "bl64_k8s_run_kubectl: CLI runs ok" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_k8s_setup
  run bl64_k8s_run_kubectl version --client=true
  assert_success
}
