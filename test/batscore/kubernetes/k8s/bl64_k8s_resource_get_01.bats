@test "bl64_k8s_resource_get: both parameters are not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_k8s_resource_get
  assert_failure
}

@test "bl64_k8s_resource_get: 2nd parameter is not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_k8s_resource_get '/dev/null'
  assert_failure
}
