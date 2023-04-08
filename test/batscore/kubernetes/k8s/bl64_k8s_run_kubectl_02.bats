setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_k8s_setup || skip 'k8s cli not found'
}

@test "bl64_k8s_run_kubectl: CLI runs ok" {
  run bl64_k8s_run_kubectl "$TESTMANSH_TEST_SAMPLES/kubectl_01/config_01" --help
  assert_success
}
