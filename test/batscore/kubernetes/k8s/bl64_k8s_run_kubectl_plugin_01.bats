setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_k8s_run_kubectl_plugin: parameters are not present" {
  run bl64_k8s_run_kubectl_plugin
  assert_failure
}
