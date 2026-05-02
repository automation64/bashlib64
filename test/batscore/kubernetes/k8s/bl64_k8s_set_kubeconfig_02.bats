setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_k8s_setup || skip 'k8s cli not found'
}

@test "bl64_k8s_set_kubeconfig: setter ok" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_k8s_setup
  run bl64_k8s_set_kubeconfig "$TESTMANSH_TEST_SAMPLES/kubectl_01/config_01"
  assert_success
}
