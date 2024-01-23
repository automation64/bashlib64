@test "bl64_k8s_namespace_create: parameters are not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_k8s_namespace_create
  assert_failure
}
