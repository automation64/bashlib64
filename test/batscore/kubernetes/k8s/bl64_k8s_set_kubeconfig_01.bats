@test "bl64_k8s_set_kubeconfig: parameters are not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_k8s_set_kubeconfig
  assert_failure
}

@test "bl64_k8s_set_kubeconfig: path not found" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_k8s_set_kubeconfig /tmp/kubeconfig_not_found
  assert_failure
}
