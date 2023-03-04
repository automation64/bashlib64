setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_k8s_resource_update: file parameter not existing" {
  run bl64_k8s_resource_update '/xxx/yy/zzz/not_existing' 'test'
  assert_failure
}
