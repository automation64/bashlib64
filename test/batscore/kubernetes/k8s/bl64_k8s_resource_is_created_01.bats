@test "bl64_k8s_resource_is_created: both parameters are not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_k8s_resource_is_created
  assert_failure
}

@test "bl64_k8s_resource_is_created: 2nd parameter is not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_k8s_resource_is_created '/dev/null'
  assert_failure
}
