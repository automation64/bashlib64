setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_k8s_label_set: parameters are not present" {
  run bl64_k8s_label_set
  assert_failure
}

@test "bl64_k8s_label_set: 2nd parameter is not present" {
  run bl64_k8s_label_set '/dev/null'
  assert_failure
}

@test "bl64_k8s_label_set: 3th parameter is not present" {
  run bl64_k8s_label_set '/dev/null' '/dev/null'
  assert_failure
}

@test "bl64_k8s_label_set: 4th parameter is not present" {
  run bl64_k8s_label_set '/dev/null' '/dev/null' '/dev/null'
  assert_failure
}
