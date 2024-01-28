@test "bl64_k8s_resource_update: file parameter not existing" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_k8s_resource_update '/xxx/yy/zzz/not_existing' 'test'
  assert_failure
}
