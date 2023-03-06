setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_k8s_resource_update: both parameters are not present" {
  run bl64_k8s_resource_update
  assert_failure
}

@test "bl64_k8s_resource_update: 2nd parameter is not present" {
  run bl64_k8s_resource_update '/dev/null'
  assert_failure
}
