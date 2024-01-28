@test "bl64_k8s_run_kubectl_plugin: parameters are not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_k8s_run_kubectl_plugin
  assert_failure
}
