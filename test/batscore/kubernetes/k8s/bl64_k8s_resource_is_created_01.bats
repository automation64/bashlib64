setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_k8s_resource_is_created: both parameters are not present" {
  run bl64_k8s_resource_is_created
  assert_failure
}

@test "bl64_k8s_resource_is_created: 2nd parameter is not present" {
  run bl64_k8s_resource_is_created '/dev/null'
  assert_failure
}
