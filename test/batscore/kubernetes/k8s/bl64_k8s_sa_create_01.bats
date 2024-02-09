@test "bl64_k8s_sa_create: both parameters are not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_k8s_sa_create
  assert_failure
}

@test "bl64_k8s_sa_create: 2nd parameter is not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_k8s_sa_create '/dev/null'
  assert_failure
}
