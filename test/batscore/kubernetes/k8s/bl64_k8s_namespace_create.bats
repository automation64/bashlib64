setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_k8s_namespace_create: parameters are not present" {
  run bl64_k8s_namespace_create
  assert_failure
}
