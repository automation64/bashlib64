setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_k8s_setup || skip 'k8s cli not found'
}

@test "bl64_k8s_run_kubectl: use default config" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_k8s_run_kubectl "$BL64_VAR_DEFAULT" --help
  assert_success
}

@test "bl64_k8s_run_kubectl: not existing config" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_k8s_run_kubectl '/xxx/yy/zzz/not_existing' 'test'
  assert_failure
}
