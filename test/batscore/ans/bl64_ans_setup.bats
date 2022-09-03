setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_ans_setup: module setup - invalid bin path" {
  run bl64_ans_setup '/no/ansible'
  assert_failure
}
