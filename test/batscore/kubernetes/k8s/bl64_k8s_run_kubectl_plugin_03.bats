setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_k8s_run_kubectl_plugin: file parameter not existing" {
  run bl64_k8s_run_kubectl_plugin '/xxx/yy/zzz/not_existing' 'test'
  assert_failure
}