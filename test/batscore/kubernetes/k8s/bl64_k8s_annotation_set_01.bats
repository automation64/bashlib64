@test "bl64_k8s_annotation_set: both parameters are not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_k8s_annotation_set
  assert_failure
}

@test "bl64_k8s_annotation_set: 2nd parameter is not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_k8s_annotation_set '/dev/null'
  assert_failure
}
