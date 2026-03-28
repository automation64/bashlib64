@test "bl64_k8s_run_kubectl_cfg: parameters are not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_k8s_run_kubectl_cfg
  assert_failure
}
