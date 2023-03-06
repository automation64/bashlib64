setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_k8s_secret_create: file parameter not existing" {
  run bl64_k8s_secret_create '/xxx/yy/zzz/not_existing' 'test'
  assert_failure
}
