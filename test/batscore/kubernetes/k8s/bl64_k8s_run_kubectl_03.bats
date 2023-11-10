setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_k8s_setup || skip 'k8s cli not found'
}

@test "bl64_k8s_run_kubectl: use default config" {
  run bl64_k8s_run_kubectl "$BL64_VAR_DEFAULT" 'version'
  assert_success
}

@test "bl64_k8s_run_kubectl: not existing config" {
  run bl64_k8s_run_kubectl '/xxx/yy/zzz/not_existing' 'version'
  assert_failure
}
