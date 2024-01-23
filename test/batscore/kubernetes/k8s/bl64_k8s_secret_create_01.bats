@test "bl64_k8s_secret_create: parameters are not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_k8s_secret_create
  assert_failure
}

@test "bl64_k8s_secret_create: 2nd parameter is not present" {
  run bl64_k8s_secret_create '/dev/null'
  assert_failure
}

@test "bl64_k8s_secret_create: 3th parameter is not present" {
  run bl64_k8s_secret_create '/dev/null' '/dev/null'
  assert_failure
}
