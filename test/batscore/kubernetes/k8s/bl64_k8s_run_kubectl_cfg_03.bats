setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_k8s_setup || skip 'k8s cli not found'
}

@test "bl64_k8s_run_kubectl_cfg: use default config" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_k8s_setup
  run bl64_k8s_run_kubectl_cfg "$BL64_VAR_DEFAULT" --help
  assert_failure
}

@test "bl64_k8s_run_kubectl_cfg: not existing config" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_k8s_setup
  run bl64_k8s_run_kubectl_cfg '/xxx/yy/zzz/not_existing' 'test'
  assert_failure
}
