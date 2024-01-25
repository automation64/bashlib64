@test "bl64_k8s_secret_copy: parameters are not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_k8s_secret_copy
  assert_failure
}

@test "bl64_k8s_secret_copy: 2nd parameter is not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_k8s_secret_copy '/dev/null'
  assert_failure
}

@test "bl64_k8s_secret_copy: 3th parameter is not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_k8s_secret_copy '/dev/null' '/dev/null'
  assert_failure
}
